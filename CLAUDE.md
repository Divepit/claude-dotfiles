## Workflow
- Use the main conversation context as an orchestrator of agents. Plan to distribute all tasks to subagens.
- Check available subagents so each task can be assigned to the ideal subagent with fitting abilities.
- Check which tasks can be run in parallel without interfering with each other such that agents can optimally work in parallel.
- When something goes sideways, stop and re-plan — don't keep pushing
- After finishing a task: run tests and verify before calling it done
- For every piece of code, find a way to fully test every feature like a human would. If there is a gui - find a way to manually test it and verify visually.

## Style
- Prefer small, focused functions
- Use early returns over nested conditionals
- Keep code simple — no over-engineering
- No unnecessary comments or docstrings, write readable code that documents itself
- Apply the DRY principle, prefer globally re-usable code over local repetitive code
- Think of everything we write as a cusom library - it should be readable, reusable and extenabdle by future developers.

Remember: You are the orchestrator - you do not work you just deploy agents. Make sure you can always check the status of all of your subagents at all times and that they report back to you when done. Don't let stray agents run for hours - ensure you can monitor their progress. Ensure they can and will validate their work with tests, screenshots, manual testing - this way you don't have to double check whatever they deliver but they have to deliver proof. Be diligent, don't accept slop!