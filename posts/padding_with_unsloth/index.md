---
title: "Left Padding with Unsloth and TRL"
draft: true
categories: [unsloth, trl, transformers, TIL]
---

- Setup: some text
- If let trl handle the tokenization, then the padding will be right even if we set `tokenizer.padding_side = "left"`
- If we want to pad left, then we need to pass the collator with `tokenizer.padding_side = "left"` set before the dataloader
- Another solution is to pass ` SFTConfig(..., dataset_kwargs={"padding_side": "left",})`
- Unsloth needs this `dataset_num_proc=num_proc` to control the number of processes used for tokenization
