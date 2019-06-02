#!/usr/bin/python
# -*- coding: utf-8 -*-
#####################################
# File name : gpu_test.py
# Create date : 2019-06-02 15:17
# Modified date : 2019-06-02 17:06
# Author : DARREN
# Describe : not set
# Email : lzygzh@126.com
#####################################
from __future__ import division
from __future__ import print_function
import gc
import datetime
import pynvml
import inspect

import torch
import numpy as np
import sys

def show(data):

    print("data %x size:%s" % (id(data), str(data.size())))

def get_tensors():
    for obj in gc.get_objects():
        try:

            if torch.is_tensor(obj) or (hasattr(obj, 'data') and torch.is_tensor(obj.data)):
                tensor = obj
            else:
                continue
            if tensor.is_cuda:
                show(tensor)
                yield tensor
        except Exception as e:
            if False:
                print('A trivial exception occured: {}'.format(e))
def gpu_log():
    stack_layer = 1
    level = "DEBUG"
    func_name = sys._getframe(stack_layer).f_code.co_name
    file_name = sys._getframe(stack_layer).f_code.co_filename
    line = sys._getframe(stack_layer).f_lineno
    now_time = datetime.datetime.now()
    log_format = 'LEVEL:%s, LINE:%s, FUNC:%s, FILE:%s, TIME:%s, CONTENT:%s\n'
    #con = log_format % (level, line, func_name, file_name, now_time, content)
    
    pynvml.nvmlInit()
    handle = pynvml.nvmlDeviceGetHandleByIndex(0)
    meminfo = pynvml.nvmlDeviceGetMemoryInfo(handle)

    #self.curr_line = self.frame.f_lineno
    #where_str = self.module_name + ' ' + self.func_name + ':' + ' line ' + str(self.curr_line)
    gpu_profile_fn = "" + 'gpu_mem_track.txt'

    with open(gpu_profile_fn, 'a+') as f:
        f.write("Total Used Memory:%f Mb\n\n" % float(meminfo.used/1024**2))
        ts_list = [tensor.size() for tensor in get_tensors()]
        new_tensor_sizes = {(type(x), tuple(x.size()), ts_list.count(x.size()), np.prod(np.array(x.size()))*4/1000**2)
                            for x in get_tensors()}
        for t, s, n, m in new_tensor_sizes:
            f.write('| %s * Size:%s | Memory: %s M | %s\n' %(str(n), str(s), str(m*n)[:6], str(t)))

        content = "%s" % str(meminfo.used/1024**2)
            
        con = log_format % (level, line, func_name, file_name, now_time, content)

        #f.write("\nAt %s Total Used Memory:%f Mb\n\n" % (where_str, ))
        f.write("\n%s" % con)

    pynvml.nvmlShutdown()
import torch

dtype = torch.float


N, D_in, H, D_out = 64, 1000, 100, 10


#frame = inspect.currentframe()          # define a frame to track
#gpu_tracker = MemTracker(frame)         # define a GPU tracker

#gpu_log()
device = torch.device("cuda")
x = torch.randn(N, D_in, device=device, dtype=dtype)
y = torch.randn(N, D_out, device=device, dtype=dtype)
device = torch.device("cpu")
x = torch.randn(N, D_in, device=device, dtype=dtype)
y = torch.randn(N, D_out, device=device, dtype=dtype)

w1 = torch.randn(D_in, H, device=device, dtype=dtype, requires_grad=True)
w2 = torch.randn(H, D_out, device=device, dtype=dtype, requires_grad=True)


learning_rate = 1e-6
for t in range(500):

    h = x.mm(w1)
    h2 = h.clamp(min=0)
    y_pred = h2.mm(w2)
    #y_pred = x.mm(w1).clamp(min=0).mm(w2)

    # Compute and print loss using operations on Tensors.
    # Now loss is a Tensor of shape (1,)
    # loss.item() gets the a scalar value held in the loss.
    loss = (y_pred - y).pow(2).sum()
    print(t, loss.item())

    # Use autograd to compute the backward pass. This call will compute the
    # gradient of loss with respect to all Tensors with requires_grad=True.
    # After this call w1.grad and w2.grad will be Tensors holding the gradient
    # of the loss with respect to w1 and w2 respectively.
    loss.backward()


    with torch.no_grad():


        show(w1)
        show(w2)
        w1_grad = w1.grad
        w2_grad = w2.grad
        show(w1_grad)
        show(w2_grad)
        w1 -= learning_rate * w1.grad

        w2 -= learning_rate * w2.grad



        w1.grad.zero_()
        w2.grad.zero_()

    gpu_log()
