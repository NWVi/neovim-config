return {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        features = 'all',
      },
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}
