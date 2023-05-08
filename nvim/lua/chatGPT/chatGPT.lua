local aikey = os.getenv("OPENAI_API_KEY")
local chatgpt = require("chatgpt").openChat


vim.keymap.set("n" , "<Leader>gg", chatgpt, {buffer = 0})

if aikey then 
    require("chatgpt").setup{
       chat = {
       toggle_settings = "<C-s>",
    }
}
else 
    print("no ai key")
end

