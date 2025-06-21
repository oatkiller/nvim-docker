# Why Story Splitting Matters - Abridged

A good user story follows the **INVEST** model:
- **I**ndependent: Can be worked on without depending on other stories.
- **N**egotiable: Details can be collaboratively refined.
- **V**aluable: Delivers clear value to the user.
- **E**stimable: The team can estimate the effort.
- **S**mall: Small enough to be completed in a short timeframe (e.g., a fraction of a sprint).
- **T**estable: There are clear criteria to confirm it's done.

When a story is too large, use these patterns to split it into smaller, valuable vertical slices:

1.  **Workflow Steps**: If a story involves a multi-step process, don't split it into one story per step. Instead, implement a simple end-to-end version first, then add intermediate steps (like approvals or reviews) as separate stories later.

2.  **Operations (CRUD)**: A story to "manage" something (e.g., "manage my account") can be split by operation: Create, Read, Update, Delete. (e.g., "sign up for an account", "edit my account settings", "cancel my account").

3.  **Business Rule Variations**: If a story's complexity comes from different business rules, create a separate story for each rule. (e.g., "search for flights with flexible dates" becomes separate stories for different definitions of "flexible").

4.  **Data Variations**: If a story handles many types of data, create a story for the simplest or most common data type first, and add others later. (e.g., "create news stories in English", then "in Japanese", then "in Arabic").

5.  **Data Entry Methods**: If complexity is in the UI, build the feature with a very simple UI first, then create a separate story to add a more complex/fancy UI later.

6.  **Major Effort**: If most of the effort is in the first part of a story (e.g., setting up infrastructure for payment processing), split it into "implement for one case" and "extend to all other cases". (e.g., "pay with one credit card type" and "add support for all other card types").

7.  **Simple/Complex**: When a story grows with many "what if" scenarios, isolate the simplest possible version that still delivers value. Move all other variations and complexities into separate stories.

8.  **Defer Performance**: If making a feature fast is the hard part, first create a story to "make it work" (even if it's slow), and then a separate story to "make it fast".

9.  **Break Out a Spike**: If a story is large because of technical uncertainty, create a time-boxed "spike" story to investigate and answer specific technical questions. Once the spike is done, the original story can be estimated and split more easily. This is a last resort.

**Meta-Pattern**: Find the core complexity, identify all the variations (of data, rules, users, etc.), and reduce them to the simplest possible case for the first story. 