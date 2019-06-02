#!/bin/bash
#####################################
## File name : check_code.sh
## Create date : 2018-11-25 15:57
## Modified date : 2019-03-20 13:23
## Author : DARREN
## Describe : not set
## Email : lzygzh@126.com
####################################

realpath=$(readlink -f "$0")
export basedir=$(dirname "$realpath")
export filename=$(basename "$realpath")
export PATH=$PATH:$basedir/dlbase
export PATH=$PATH:$basedir/dlproc
#base sh file
. dlbase.sh
#function sh file
. etc.sh

#   source $env_path/py2env/bin/activate
#   pip freeze > python2_requiements.txt
#   deactivate

source $env_path/py3env/bin/activate
pylint --rcfile=pylint.conf main.py
pylint --rcfile=pylint.conf etc.py
pylint --rcfile=pylint.conf func.py
pylint --rcfile=pylint.conf show.py
pylint --rcfile=pylint.conf train_graph.py
pylint --rcfile=pylint.conf eval_graph.py
pylint --rcfile=pylint.conf rocstories_dataset.py

pylint --rcfile=pylint.conf ./openai_gpt/gpt_double_heads_model.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt_lm_head_model.py

pylint --rcfile=pylint.conf ./openai_gpt/gpt/gpt_cache.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/gpt_config.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/gpt_opt.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/gpt_pretrained_model.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/gpt_token.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/gpt_transformer.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/load_model.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/model_base.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/model_block.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/model_lm_head.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/model_multiple_choice_head.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/token_basic.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/token_bpe.py
pylint --rcfile=pylint.conf ./openai_gpt/gpt/base_gpt/token_tf_torch.py

pip freeze > python3_requiements.txt
deactivate
