# Foundational Large Language Models & Text Generation

A language model is a probabilistic model of a natural language [1]. It predicts the probability of a sequence of words. Current categorization of language models according to a popular survey paper [2] is such that:

- Statistical language models
- Neural language models
- Pre-trained language models (BERT)****
- Large language models (GPT)

Transformers are sequence to sequence machine learning models. Main difference between recurrent neural networks such as long short term memory  (LSTM), gated recurrent unit (GRU) architectures and transformers is its capacity to process tokens in parallel. There are three types: encoder only, decoder only and an encoder-decoder. 

```
Input Sequence
      │
      ▼
+-------------+
| Embedding   | 
+-------------+
      │
      ▼
+--------------------+
| Positional Encoding|
+--------------------+
      │
      ▼ 
+---------------------+     +----------------------+
| Multi-Head Attention|     | Multi-Head Attention |
|   (Self-Attention)  |     | (  Encoder-Decoder   |
+---------------------+     |      Attention)      |
      │                     +----------------------+
      ▼
+--------------------+      +----------------------+
|   Add & Norm       |      |     Add & Norm       |
+--------------------+      +----------------------+
      │                           │
      ▼                           ▼
+--------------------+      +----------------------+
| Feed Forward       |      | Multi-Head Attention |
+--------------------+ |--> |  (Self-Attention)    |
      │                |    +----------------------+
      ▼                |          |
+--------------------+ |          ▼
| Add & Norm         | |   +-----------------------+
+--------------------+ |   |   Add & Norm          |
      │                |   +-----------------------+    
      ▼                |          │
  (Repeat N times)     |          ▼
                       |       Feed Forward
      │                |          │
      ▼                |          ▼
    Encoder-output   --   +----------------------+
                          | Add & Norm           |
                          +----------------------+
                                  │
                                  ▼
                           (Repeat N times)
                                  │
                                  ▼
                               Decoder
                                  │
                                  ▼
                         +------------------+
                         | Linear & Softmax |
                         +------------------+
                                 │
                                 ▼
                           Output Sequence

```
> Attention mechanism produces context dependent embeddings of the input sequences 
> $$\text{Sequence of tokens } x = ( x_{1}, \dots , x_{n}) ~ x_{i} \in R^{d} $$
> $$\text{Query: } Q = X \cdot W_{q}, ~ X \in R^{n \times d}, ~ W_{q} \in R^{d \times k} $$ 
> $$\text{Key: } K = X \cdot W_{k}, ~ X \in R^{n \times d}, ~ W_{K} \in R^{d \times k} $$ 
> $$\text{Value: } V = X \cdot W_{v}, ~ X \in R^{n \times d}, ~ W_{v} \in R^{d \times k} $$ 
> 
> $$Attention(Q,K,V) = softmax(\frac{ Q \times K}{\sqrt{d_{k}}}) \times V$$

Multi head attention focuses on the different parts of the input so that more information can be retracted about the context. 

Layer normalization is about preventing covariate shift and faster convergence. Add operation is helping with vanishing gradients. Both applied to attention and feed forward modules.

The evolution of transformers goes like this: encoder-decoder model in [3] by Vaswani, decoder only generative pretrained transformer (GPT) using unsupervised training with task specific input, encoder only BeRT using masked language training. Finally, mixture of experts models such that they are sparsely activated meaning only certain models are used in inference.

Generally, LLMs are pretrained with huge amount of data in unsupervised manner and then fined tuned. Second step uses a supervised fine tuning and reinforcement learning from human feedback (RLHF). Reward model is used to guide model according to requirements. Instead of humans, AI based reinforcement approach also can be used RLAIF.

Mentioned fine tuning approaches are very costly. For this reason parameter efficient fine tuning (PEFT) is designed. Mainly, this only changes a small set of model weights.Parameter efficient fine tuning
  - **Adaptor** based fine tuning
  - Low rank adaptation
  - Soft prompting

Prompt engineering consists of 3 main methods: zero-shot prompting using no examples and only instructions, few-shot instructions with few examples and finally chain of thought using step by step reasoning.

Sampling techniques guide the next token prediction according a chosen approach: 
- **greedy** chooses the most probable, 
- **random** does exactly what you expect it to do, 
- **temperature** changes the token probabilities to increase diversity, 
- **top-k** randomly samples the most probable k tokens,
- **top-p** samples from subset with probabilities sum up to p
- **best-of-N** generates N different options and chooses one according to some metric.

In its core, speeding up inference basically demands decreasing the number of operations. We can divide main methods into two:
- **Approximation:** First approach would be using smaller precision weights instead of standard 32 bit floats which is called quantisation. Another approach would be to decrease the number of weights meaning instead of 70B model use 7B model. This is called distillation.
- **Output preserving:** Flash attention, prefix caching and speculative decoding.


# References

[1] Language Model, https://en.wikipedia.org/wiki/Language_model 

[2] Zhao, Wayne Xin, et al. "A survey of large language models." arXiv preprint arXiv:2303.18223 (2023).

[3] Vaswani, A. "Attention is all you need." Advances in Neural Information Processing Systems (2017).