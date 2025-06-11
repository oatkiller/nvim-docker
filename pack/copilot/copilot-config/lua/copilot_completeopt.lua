require("CopilotChat").setup()

-- Add 'popup' to completeopt if not already present
if not string.find(vim.o.completeopt, 'popup') then
  vim.o.completeopt = vim.o.completeopt .. ',popup'
end 