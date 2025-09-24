---
layout: post
title:  Normalization in Transformers
description: Normalization Methods in Transformers
author: "Mahamadi NIKIEMA"
thumbnail-img: profile.jpg
tags: [Python, LLMs, Deep Learning]
date:   2025-08-15 14:04:51 +0200
categories: Deep Learning
---


## Introduction

Normalization techniques are widely used in Deep Learning. In Transformers, normalization is applied at various points to maintain stable gradients and enable faster convergence. They are used in the following ways:

**Key benefits of normalization:**

-   Prevents overfitting.
-   Improves generalization.
-   Stabilizes training dynamics.
-   Boosts performance on large-scale tasks.

## Normalization Methods in Transformers

There are many normalization methods in Transformers. Some of them are:

- **Layer Normalization (LayerNorm)**
- **Root Mean Square Normalization (RMSNorm)**

## LayerNorm

LayerNorm is a normalization method that is used in the original Transformer model. It is used to normalize the input to the model. The formula for LayerNorm is:

$$
y = \gamma \times \frac{x - \mu}{\sigma + \epsilon} + \beta
$$

- $x$: Input tensor  
- $\mu$: Mean of the features  
- $\sigma$: Standard deviation of the features  
- $\epsilon$: Small constant for numerical stability  
- $\gamma$, $\beta$: Learnable scale and bias parameters  


**PyTorch Implementation:**

```python
import torch
import torch.nn as nn

class SimpleLayerNorm(nn.Module):
    def __init__(self, layer_shape, eps: float = 1e-6) -> None:
        super().__init__()
        self.layer_shape = (layer_shape,) if isinstance(layer_shape, int) else tuple(layer_shape)
        self.eps = eps
        self.gamma = nn.Parameter(torch.ones(*self.layer_shape))
        self.beta = nn.Parameter(torch.zeros(*self.layer_shape))

    def forward(self, x: torch.Tensor):
        start_dim = x.dim() - len(self.layer_shape)
        norm_dim = tuple(range(start_dim, x.dim()))
        variance = x.var(norm_dim, keepdim=True, unbiased=False)
        mean = x.mean(norm_dim, keepdim=True)
        norm_x = (x - mean) / torch.sqrt(variance + self.eps)
        norm_x = self.gamma*norm_x + self.beta
        return norm_x
```

## RMSNorm

**RMSNorm** is a more recent variant used in models like LLaMA-3 and Qwen-3.
It removes the mean subtraction step, normalizing only by the Root Mean Square (RMS) of activations.

$$
y = \frac{x}{\sqrt{\epsilon + \sum_{i=1}^n x_i^2}}$$
where $x$ is the input, $y$ is the output, and $\epsilon$ is a small constant.

In Python, you can use the following code to implement RMSNorm:


```python
import torch
import torch.nn as nn


class RMSNorm(nn.Module):
    def __init__(self, emb_dim, eps=1e-6, bias=False, qwen3_compatible=True):
        super().__init__()
        self.eps = eps
        self.qwen3_compatible = qwen3_compatible
        self.scale = nn.Parameter(torch.ones(emb_dim))
        self.shift = nn.Parameter(torch.zeros(emb_dim)) if bias else None

    def forward(self, x):
        input_dtype = x.dtype

        if self.qwen3_compatible:
            x = x.to(torch.float32)

        variance = x.pow(2).mean(dim=-1, keepdim=True)
        norm_x = x * torch.rsqrt(variance + self.eps)
        norm_x = norm_x * self.scale

        if self.shift is not None:
            norm_x = norm_x + self.shift

        return norm_x.to(input_dtype)
```

``RMSNorm`` is computationally more efficient than `LayerNorm` and is used in many models today such as `QWen-3` and `LLaMA-3`.

## Conclusion

Normalization is critical for stable and efficient Transformer training.
While `LayerNorm` remains the standard choice, `RMSNorm` is increasingly popular in large-scale LLMs for its computational efficiency.


## Further Reading

- [RMSNorm: The Root Mean Square Layer Normalization](https://arxiv.org/abs/1910.07467)
- [Layer Normalization](https://arxiv.org/abs/1607.06450)
- [Attention is all you need](https://arxiv.org/abs/1706.03762)