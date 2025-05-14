---
layout: post
title:  From Python to Rust
description: Pythonista becomming a Rustacean
author: "Mahamadi NIKIEMA"
thumbnail-img: profile.jpg
draft: true
tags: [Python, Rust, Programming]
date:   2025-04-25 21:55:51 +0200
categories: programming
---

## Introduction

I am a Pythonista, and I have been using Python for a while now for machine learning. I love the language, its simplicity, and its vast ecosystem of libraries. However, I have always been curious about Rust. I have heard a lot of good things about it, especially its performance and safety features. So, I decided to take the plunge and learn Rust.

## What did I learn?

Rust is a systems programming language that focuses on performance, safety, and concurrency. It is designed to be fast and efficient, with zero-cost abstractions. This means that you can write high-level code without sacrificing performance. Rust also has a strong type system and ownership model, which helps prevent common programming errors such as null pointer dereferences and data races.

### Mutability

In Python, variables are mutable by default. This means that you can change the value of a variable at any time. In Rust, variables are immutable by default. This means that once you assign a value to a variable, you cannot change it unless you explicitly declare it as mutable using the `mut` keyword.

```rust
fn main() {
    let x = 5; // immutable
    // x = 6; // error: cannot assign twice to immutable variable `x`
    let mut y = 5; // mutable
    y = 6; // ok
    println!("x: {}, y: {}", x, y);
}
```
### Functions 
In Python, you define functions using the `def` keyword. In Rust, you define functions using the `fn` keyword. Rust also has a concept of function signatures, which specify the types of the function's parameters and return value.

```rust
fn add(x: i32, y: i32) -> i32 {
    x + y
}
fn main() {
    let result = add(5, 6);
    // res = add(x=5, y=6) // error: rust does not support keyword arguments
    println!("Result: {}", result);
}
```

### Stack, Heap and Borrowing

In Python, memory management is handled by the garbage collector. In Rust, you have more control over memory management. Rust uses a system of ownership and borrowing to manage memory. This means that you can allocate memory on the stack or heap, and you have to explicitly manage the lifetime of your variables.

```rust
fn main() {
    let x = 5; // stack
    let y = Box::new(6); // heap
    println!("x: {}, y: {}", x, *y);
}
```


## Conclusion
Learning Rust has been a challenging but rewarding experience. I have learned a lot about memory management, performance, and safety. I am excited to continue my journey with Rust and explore its vast ecosystem of libraries and tools. I hope this post helps other Pythonistas who are considering learning Rust.
## Resources
- [The Rust Programming Language](https://doc.rust-lang.org/book/)
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/)
- [Rustlings](https://rustlings.rs/)
- [Rust Playground](https://play.rust-lang.org/)
- [100 Exercises To Learn Rust](https://rust-exercises.com/100-exercises/)