# Story Splitting Flowchart (Text Version)

This flowchart helps guide the process of splitting a large user story into smaller, manageable pieces.

## Part 1: Prepare the Story for Splitting

1.  **Check for Value (INVEST)**:
    -   Does the story deliver a tangible, vertical slice of value to a user?
    -   **If NO**: The story is likely a task or component. Combine it with other pieces until you have a feature that provides real user value. Do not proceed until the story is valuable.
    -   **If YES**: Proceed to the next step.

2.  **Check for Size (INVEST)**:
    -   Is the story small enough to be completed quickly (e.g., 6-10 stories per sprint)?
    -   **If NO**: The story is too big and needs to be split. Proceed to Part 2.
    -   **If YES**: The story is already well-sized. No splitting is needed.

## Part 2: Apply Splitting Patterns

Try to split the story using one or more of the following patterns. See ['Why Story Splitting Matters - Abridged'](mdc:tasks/why_story_splitting_matters_abridged.md) for details on each.

-   **Pattern 1: Workflow Steps** (e.g., Simple end-to-end path first, then add complexity).
-   **Pattern 2: Operations** (e.g., CRUD: Create, Read, Update, Delete).
-   **Pattern 3: Business Rule Variations** (e.g., One story per business rule).
-   **Pattern 4: Variations in Data** (e.g., One story per data type).
-   **Pattern 5: Data Entry Methods** (e.g., Simple UI first, then fancy UI).
-   **Pattern 6: Major Effort** (e.g., "Implement for one" then "extend to all").
-   **Pattern 7: Simple/Complex** (e.g., Separate the core simple case from complex variations).
-   **Pattern 8: Defer Performance** (e.g., "Make it work" then "make it fast").
-   **Pattern 9: Break Out a Spike** (e.g., A time-boxed investigation to reduce uncertainty).

*Hint: If multiple patterns apply, proceed to Part 3 to evaluate which split is best.*

## Part 3: Evaluate the Split

Once you have a potential split, ask these questions:

1.  **Does the split allow you to discard or deprioritize something?**
    -   A good split often isolates the high-value core from lower-value "nice-to-haves". Choose the split that allows the Product Owner to discard the low-value parts.

2.  **Does the split result in roughly equal-sized stories?**
    -   A split that creates four 2-point stories is generally better than one that creates a 5-point story and a 3-point story, as it provides more flexibility for planning.

If the resulting stories are still too big, apply the flowchart to them recursively. 