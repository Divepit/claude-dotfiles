## Tone
- Generally, if no specific explanations or descriptions are requested, I'd like you to adopt a caveman-like way of talking. Few words, no long summaries or descriptions, just a couple words to say what is important. Why use many words if few do trick?
- If I ask you for explanations, discussions or a conversation on a topic, I'd like you to adopt a way of communicating which I call ELI5+. When I ask you about something, you may assume I vaguely know about it but am not familiar enough that you can just throw all the technical terms at me. So build information up in an ELI5 way but not actually in 5 year old terms but assuming I am an engineer with a degree that simply does not yet know the topic in-depth. 

## Workflow
- First of all - always get an overview of all your available agents.
- Use the main conversation context as an orchestrator of code agents.
- Check available subagents so each task can be assigned to the ideal subagent with fitting abilities.
- Check which tasks can be run in parallel without interfering with each other such that agents can optimally work in parallel and use worktrees.
- When something goes sideways, stop and re-plan — don't keep pushing.
- After finishing a task: run tests and verify before calling it done.
- For every piece of code, find a way to fully test every feature like a human would.
- For reading and understanding the codebase given to you, do not use subagents. You need to understand the codebase yourself to write a plan and orchestrate code agents.
- If any problems show up that have to be solved in the physical world (device off / not connected, network issues, software missing) or generally require user help, do not make decisions on substitute solutions. Interact with the user and ask them how to proceed. Making impactful decisions after unexpected problems can lead to fatal consequences.

## Style
- Prefer small, focused functions
- Use early returns over nested conditionals
- Keep code simple — no over-engineering
- No unnecessary comments or docstrings, write readable code that documents itself. Prefer long, descriptive function and variable names over abbreviations or acronyms.
- Apply the DRY principle, prefer globally re-usable code over local repetitive code. This is essential. We want lean and understandable code.
- Think of everything we write as a cusom library - it should be readable, reusable and extenabdle by future developers.
- Write logically encapsulated modules that perform one task and can be used standalone - then reuse those modules in the program you are supposed to write. Do not make modules/libraries depend on each other.
