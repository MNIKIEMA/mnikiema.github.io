default:
    @just --list

# Render to docs
render:
    quarto render

# preview some changes
preview:
    quarto preview

# Show current version
version:
    @uv version --short

build:
    echo "Building"

test: build
    echo "Testing"

@foo:
  pwd

@bar:
  pwd

fo argument:
  touch {{argument}}
