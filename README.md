# Excalidraw Lab

Local Excalidraw canvas wired for AI agents (Cursor MCP) so you can learn concepts with live diagrams, charts, labels, and explanations drawn on a shared whiteboard.

## What you get

| Piece | Role |
| --- | --- |
| **Live canvas** (`http://127.0.0.1:3000`) | Watch the AI draw in real time |
| **Cursor MCP** (`.cursor/mcp.json`) | Agent draws via Excalidraw tools |
| **`diagrams/`** | Export `.excalidraw` files you can commit |
| **Optional Docker** (`:5000`) | Vanilla Excalidraw UI only (no MCP sync) |

Powered by [`mcp-excalidraw-server`](https://github.com/yctimlin/mcp_excalidraw) — a persistent canvas workbench (create / edit / screenshot / export), not a one-shot chat widget.

## Prerequisites

- **Node.js ≥ 20** (this machine has Node 24+)
- Cursor (for MCP), or any MCP client
- Optional: Docker, for the vanilla UI on port 5000

If `npx` fails with `EACCES` on `~/.npm`, either run `sudo chown -R $(whoami) ~/.npm` or keep using the project `.npmrc` (points cache at `~/.npm-user-cache`).

## Quick start

```bash
cd excalidraw-lab

# 1. Start the MCP-backed canvas (auto-starts on first MCP/CLI draw too)
npm run start

# 2. Open the whiteboard
npm run open
# → http://127.0.0.1:3000

# 3. In Cursor: reopen this folder, enable the `excalidraw` MCP server
#    (Settings → MCP, or trust project `.cursor/mcp.json`)
```

Then ask the agent something like:

> Draw a clear diagram explaining how a Redis cache sits in front of Postgres for a read-heavy API. Label each box, show the read path with arrows, and add a short note for cache miss vs hit.

Keep the browser tab open to watch it draw live.

## Useful commands

```bash
npm run start      # start canvas on :3000
npm run stop       # stop canvas
npm run status     # health / URL
npm run open       # open browser
npm run canvas     # start + open
npm run export     # save scene → diagrams/latest.excalidraw
npm run skill      # install drawing skill under .agents/skills

# Optional vanilla Excalidraw (no AI sync) on :5000
npm run docker:up
npm run docker:down
```

CLI without npm scripts:

```bash
npx -y mcp-excalidraw-server start
npx -y mcp-excalidraw-server describe
npx -y mcp-excalidraw-server screenshot --out diagrams/shot.png
npx -y mcp-excalidraw-server export --out diagrams/concept.excalidraw
```

## Cursor MCP

Project config is already in [`.cursor/mcp.json`](.cursor/mcp.json):

```json
{
  "mcpServers": {
    "excalidraw": {
      "command": "npx",
      "args": ["-y", "mcp-excalidraw-server"],
      "env": {
        "EXPRESS_SERVER_URL": "http://127.0.0.1:3000",
        "ENABLE_CANVAS_SYNC": "true",
        "EXCALIDRAW_EXPORT_DIR": "diagrams"
      }
    }
  }
}
```

For a global Cursor install, copy the same block into `~/.cursor/mcp.json`.

Optional official chat widget (inline diagrams in Claude/ChatGPT): [mcp.excalidraw.com](https://mcp.excalidraw.com) — different product; this lab uses the persistent local canvas.

## Learning workflow

1. Open `http://127.0.0.1:3000` beside Cursor.
2. Ask for a concept diagram (architecture, data flow, algorithm, mental model).
3. Ask follow-ups: “zoom in on the cache miss path”, “add a sequence for auth”, “replace boxes with a Mermaid flowchart”.
4. Export keepers into `diagrams/` and commit them with your notes.

Prompt pattern that works well:

```text
Explain <concept> on the Excalidraw canvas:
- layout top → bottom or left → right
- short labels, callouts for the non-obvious bits
- one “key insight” text box
- screenshot when done so you can fix overlap
```

## Security

The canvas binds to `127.0.0.1` only by default. Do not expose `HOST=0.0.0.0` without network controls — the API has no auth.

## License

MIT. Excalidraw and `mcp-excalidraw-server` retain their own licenses.
