## Workflow
- Use the main conversation context as an orchestrator of code agents. Plan to distribute all parallelizable code tasks to subagents.
- Check available subagents so each task can be assigned to the ideal subagent with fitting abilities.
- Check which tasks can be run in parallel without interfering with each other such that agents can optimally work in parallel and use worktrees.
- When something goes sideways, stop and re-plan — don't keep pushing
- After finishing a task: run tests and verify before calling it done
- For every piece of code, find a way to fully test every feature like a human would.
- For reading and understanding the codebase given to you, do not use subagents. You need to understand the codebase yourself to write a plan and orchestrate code agents.
- If any problems show up that have to be solved in the physical world (device off / not connected, network issues, software missing) do not make decisions on substitute solutions. Interact with the user and ask them how to proceed.

## Style
- Prefer small, focused functions
- Use early returns over nested conditionals
- Keep code simple — no over-engineering
- No unnecessary comments or docstrings, write readable code that documents itself
- Apply the DRY principle, prefer globally re-usable code over local repetitive code. This is essential. We want lean and understandable code.
- Think of everything we write as a cusom library - it should be readable, reusable and extenabdle by future developers.
- Write logically encapsulated modules that perform one task and can be used standalone - then reuse those modules in the program you are supposed to write.
