default:
    @just --list

# Render to docs
render:
    quarto render

# preview some changes
preview:
    quarto preview


# Lint Markdown/Quarto files
lint:
    uv run rumdl check .

# Auto-fix Markdown/Quarto issues
fmt:
    uv run rumdl fmt .
