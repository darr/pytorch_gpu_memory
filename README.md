# pytorch_gpu_memory
pytorch gpu memory check

## how to use gpu_memory_log

```python
import torch
from gpu_memory_log import gpu_memory_log

dtype = torch.float
N, D_in, H, D_out = 64, 1000, 100, 10

device = torch.device("cuda")
x = torch.randn(N, D_in, device=device, dtype=dtype)
y = torch.randn(N, D_out, device=device, dtype=dtype)

w1 = torch.randn(D_in, H, device=device, dtype=dtype, requires_grad=True)
w2 = torch.randn(H, D_out, device=device, dtype=dtype, requires_grad=True)

learning_rate = 1e-6
gpu_memory_log()
for t in range(500):
    y_pred = x.mm(w1).clamp(min=0).mm(w2)
    loss = (y_pred - y).pow(2).sum()
    #print(t, loss.item())
    loss.backward()
    with torch.no_grad():
        w1 -= learning_rate * w1.grad
        w2 -= learning_rate * w2.grad

        w1.grad.zero_()
        w2.grad.zero_()

print(loss.item())
gpu_memory_log()
```
yes, just put the code gpu_memory_log() , where you want to see the gpu memory status
so easy.

## how to run

you can choose how to run.
this will run gpu_test.py
```shell
bash gpu_run.sh
```

output
```shell
LINE:27, FUNC:<module>, FILE:gpu_test.py, TIME:2019-06-02 17:16:23.288399, CONTENT:
/home/liuzy/.pytorch_gpu_memory_env/py3env/lib/python3.5/site-packages/torch/distributed/distributed_c10d.py:100: UserWarning: torch.distributed.reduce_op is deprecated, please use torch.distributed.ReduceOp instead
  warnings.warn("torch.distributed.reduce_op is deprecated, please use "
[tensor: 1 * Size:(100, 10) | Memory: 0.0038 M | <class 'torch.Tensor'>]
[tensor: 1 * Size:(64, 1000) | Memory: 0.2441 M | <class 'torch.Tensor'>]
[tensor: 1 * Size:(64, 10) | Memory: 0.0024 M | <class 'torch.Tensor'>]
[tensor: 1 * Size:(1000, 100) | Memory: 0.3814 M | <class 'torch.Tensor'>]
memory_allocated:1.457520 Mb
max_memory_allocated:1.457520 Mb
memory_cached:2.000000 Mb
max_memory_cached:2.000000 Mb
Used Memory:9983.625000 Mb
Free Memory:1185.625000 Mb
Total Memory:11169.250000 Mb
0.0032593868672847748
LINE:41, FUNC:<module>, FILE:gpu_test.py, TIME:2019-06-02 17:16:23.791826, CONTENT:
[tensor: 1 * Size:(100, 10) | Memory: 0.0038 M | <class 'torch.Tensor'>]
[tensor: 1 * Size:() | Memory: 3.8146 M | <class 'torch.Tensor'>]
[tensor: 1 * Size:(64, 1000) | Memory: 0.2441 M | <class 'torch.Tensor'>]
[tensor: 2 * Size:(64, 10) | Memory: 0.0048 M | <class 'torch.Tensor'>]
[tensor: 1 * Size:(1000, 100) | Memory: 0.3814 M | <class 'torch.Tensor'>]
memory_allocated:1.846191 Mb
max_memory_allocated:2.252930 Mb
memory_cached:4.000000 Mb
max_memory_cached:4.000000 Mb
Used Memory:9989.625000 Mb
Free Memory:1179.625000 Mb
Total Memory:11169.250000 Mb
```

this will run gpu_test.ipynb, just open the jupyter
```shell
bash run.sh
```


