# ==============================================================================
# Enquête : perceptions de l'IA et de la robotique chez les étudiants en santé
# UE Techniques d'enquête - Licence MIASHS, Université de Bordeaux (2025-2026)
# Analyse univariée et bivariée des réponses au questionnaire
# ==============================================================================

# ---- 1. Import des données
# read.table avec fileEncoding="latin1" pour gérer les accents
# quote="" évite les erreurs si des guillemets sont présents dans le texte
don <- read.table("Questionnaire_data.csv", header = TRUE, sep = "\t",
                  quote = "", fileEncoding = "latin1", fill = TRUE)

# ---- Sélection de la population cible (filière Santé)
# grep sur "Sant" pour éviter les problèmes d'accents sur "Santé"
lignes_sante <- grep("Sant", don$Q3)
don_sante <- don[lignes_sante, ]
nrow(don_sante)   # 38 observations attendues

# ---- Codage des variables
# Variables quantitatives (notes de 0 à 10)
don_sante$Q12 <- as.numeric(as.character(don_sante$Q12)) # Aide perçue
don_sante$Q25 <- as.numeric(as.character(don_sante$Q25)) # Performance clinique perçue
don_sante$Q6  <- as.numeric(as.character(don_sante$Q6))  # Connaissance de l'IA

# Variables qualitatives (facteurs)
don_sante$Q13 <- as.factor(don_sante$Q13) # L'IA remplace-t-elle le travail ?
don_sante$Q15 <- as.factor(don_sante$Q15) # Vérification des résultats de l'IA
don_sante$Q8  <- as.factor(don_sante$Q8)  # Fréquence d'usage
don_sante$Q24 <- as.factor(don_sante$Q24) # Sentiment global

# ==============================================================================
# 2. ANALYSE UNIVARIÉE
# ==============================================================================

# ---- Hypothèse 1 : accès et performance
summary(don_sante$Q12)
sd(don_sante$Q12, na.rm = TRUE)
hist(don_sante$Q12, main = "Distribution de l'aide perçue (Q12)",
     xlab = "Score (0-10)", col = "skyblue")

summary(don_sante$Q25)
sd(don_sante$Q25, na.rm = TRUE)
boxplot(don_sante$Q25, main = "Performance clinique perçue (Q25)",
        ylab = "Score (0-10)", col = "lightcoral")

# ---- Hypothèse 2 : aide ou substitut
table(don_sante$Q13)
prop.table(table(don_sante$Q13))
barplot(table(don_sante$Q13), main = "L'IA remplace-t-elle le travail ? (Q13)",
        col = "plum", ylab = "Effectifs")

# ---- Hypothèse 3 : usage modéré
table(don_sante$Q8)
par(mar = c(10, 4, 4, 2))
barplot(table(don_sante$Q8), main = "Fréquence d'utilisation (Q8)",
        col = "orange", las = 2)
par(mar = c(5, 4, 4, 2))

# ==============================================================================
# 3. ANALYSE BIVARIÉE (tests d'hypothèses)
# ==============================================================================

# ---- H1 : quantitatif - quantitatif (aide vs performance)
plot(don_sante$Q12, don_sante$Q25, main = "Aide (Q12) vs Performance (Q25)",
     xlab = "Aide", ylab = "Performance", pch = 19, col = "blue")
cor(don_sante$Q12, don_sante$Q25, use = "complete.obs")
cor.test(don_sante$Q12, don_sante$Q25)

# ---- H2 : qualitatif - qualitatif (sentiment vs vérification)
tab_croise <- table(don_sante$Q24, don_sante$Q15)
print(tab_croise)
chisq.test(tab_croise)

# ---- H3 : qualitatif - quantitatif (fréquence vs performance)
eta2 <- function(x, y) {
  moyennes  <- tapply(y, x, mean, na.rm = TRUE)
  effectifs <- tapply(y, x, length)
  varinter  <- sum(effectifs * (moyennes - mean(y, na.rm = TRUE))^2, na.rm = TRUE)
  vartot    <- var(y, na.rm = TRUE) * (length(y) - 1)
  varinter / vartot
}
cat("Rapport eta2 :", eta2(don_sante$Q8, don_sante$Q25), "\n")

res_anova <- aov(Q25 ~ Q8, data = don_sante)
summary(res_anova)

par(mar = c(10, 4, 4, 2))
boxplot(Q25 ~ Q8, data = don_sante, main = "Performance selon la fréquence d'usage",
        col = rainbow(6), las = 2)
