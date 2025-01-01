# Prompt Engineering

Prompt is a fancy name for input to LLMs. Since LLMs are stochastic systems, identical prompts might produce different outputs. Especially, temperature parameter drastically changes output. I like the analogy of John Berryman about temperature being blood alcohol content [1]. When it's 0, you are sober and probably a little bit boring. When it's high, you are more creative but not very reliable.

 For documenting and versioning prompts, following table can be used:

| **name**| type_classification | | |
| --- | --- | --- | --- |
| **goal** | Classify a claim as made by a gray_beard or a tech_bro | | |
| **model** | gemini-pro |
| **temperature** | 0.1| **token limit** | 5 |
| **prompt** | You are tasked with classifying a given drivel as gray_beard or tech_bro. Drivel: Stable debian is as stable as nitroglycerine Label: | | |
| **output** | tech_bro | | |

Conceptualizing prompting approaches helps to analyze input-output relationships better. Here are some common techniques:
- **system prompting:** Concerns the whole system and performed with additional task such as classify given text and output only certain labels from a provided list
- **role prompting:** Instruct model to assume a role such as "As a senior machine learning engineer..."
- **context prompting:** Frame the output according to a context such as "You are writing a think piece with the perspective of a late 60s hippie..."
- **step-back prompting:** Going from general to specific. First ask model a general question such as the most popular e-commerce blog post topics. Then give the provided topics to the model and ask it to write content choosing one of the topics.
- **chain of thought prompting:** When given task requires step by step approach, CoT approach yields better results.

Following verbs are useful for effective and simpler prompts: Act, Analyze, Categorize, Classify, Contrast, Compare, Create, Describe, Define, Evaluate, Extract, Find, Generate, Identify, List, Measure, Organize, Parse, Pick, Predict, Provide, Rank, Recommend, Return, Retrieve, Rewrite, Select, Show, Sort, Summarize, Translate, Write.

# References

[1] Berryman J., Ziegler A., "Prompt Engineering for LLMs", O'Reilly, (2024)