return {
    cmd = { "docker-language-server", "start", "--stdio" },
    filetypes = { "dockerfile", "dockercompose" },
    root_markers = {
        "Dockerfile",
        "docker-compose.yml",
        "docker-compose.yaml",
        "docker-compose.override.yml",
        "docker-compose.override.yaml",
        "compose.yml",
        "compose.yaml",
        ".git",
    },
}
