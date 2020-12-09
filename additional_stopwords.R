
additional_stopowrds <- c("nadie", "parece", "hilo", "nunca", "gente", "gusta", "personas", 
                     "bueno", "puede", "sino", "súper", "directo", "casi", "menos", "tema",
                     "00pm", "quiero","mejor", "aquí", "alguien", "quedó", "with", "jajajaja",
                     "jaja", "jajaja", "hice", "here", "llevó", "solo", "diciendo", "claro", 
                     "ustedes", "podemos", "aunque", "hola", "días", "allá", "lleno", "bien",
                     "hace", "decir", "invitación", "dicho", "hizo","quiere", "dijo", "quién",
                     "quien", "quieren", "vamos", "mismas", "click", "hacemos", "cómo", 
                     "generar", "gran", "abrazo", "gracias", "muchas", "sentido", "llevar", 
                     "cuales", "sabemos", "luego", "creo", "creen", "debería", "seguimos",
                     "pasar", "gracias", "llama", "jajajaj", "sabe", "corto", "abajo", "cosas",
                     "después", "basadas", "considerando", "haciendo", "dicen", "poner", "pensé", 
                     "cuántas", "ambas", "entiende", "tener", "pues", "mucha", "pueden", "ahora", 
                     "dice", "ahora", "mientras", "cuál", "entonces", ""), %>% 
  sort()

save(additional_stopowrds, file = "additional_stopwords.RData")
