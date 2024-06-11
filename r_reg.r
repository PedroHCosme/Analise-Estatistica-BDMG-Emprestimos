# Read the CSV file using base R's read.csv
data <- read.csv("/home/pedrocosme/tcc_beth/tcc_stats/dadosTCC_final.csv")
# data <- data[-7070,]

print(colnames(data))

# Convert factors if needed
data$`Porte do cliente` <- as.factor(data$`Porte.do.cliente`)
data$`Setor CNAE` <- as.factor(data$`Setor.CNAE`)
data$`UF` <- as.factor(data$`UF`)

# Print the number of levels and the reference category for each categorical variable
cat("Levels for 'Porte do cliente':", levels(data$`Porte do cliente`), "\n")
cat("Reference category for 'Porte do cliente':", levels(data$`Porte do cliente`)[1], "\n\n")

cat("Levels for 'UF':", levels(data$`UF`), "\n")
cat("Reference category for 'UF' :", levels(data$`UF`)[1], "\n\n")

cat("Levels for 'Setor CNAE':", levels(data$`Setor CNAE`), "\n")
cat("Reference category for 'Setor CNAE':", levels(data$`Setor CNAE`)[1], "\n\n")

# Perform log transformation on the dependent variable
data$log_valor_desembolsado <- log(data$`Valor.Desembolsado.em.Reais` + 1)  # Adding 1 to avoid log(0)

# Fit the linear regression model
model <- lm(log_valor_desembolsado ~ `Proporção.do.Valor.Setorial.ao.PIB.do.UF` + `Contribuição.do.UF.ao.PIB.Nacional....` + `Porte.do.cliente` + `Setor.CNAE`, data = data)

# Summary of the model
summary(model)

library(stargazer)
stargazer(model, type = "latex", out = "output.txt")
