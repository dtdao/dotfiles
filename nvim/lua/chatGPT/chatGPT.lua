local aikey = os.getenv("OPENAI_API_KEY")

if aikey then 
    require("chatgpt").setup{
       chat = {
       toggle_settings = "<C-s>",
    }
}
else 
    print("no ai key")
end

