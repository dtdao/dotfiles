local aikey = os.getenv("OPENAI_API_KEY")
local chatgpt = require("chatgpt").openChat


vim.keymap.set("n" , "<Leader>gg", chatgpt, {})

if aikey then 
    require("chatgpt").setup{}
else 
    print("no ai key")
end

