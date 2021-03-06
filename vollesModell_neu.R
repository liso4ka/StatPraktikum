library("arm")
library(haven)
library(mfx)
setwd("C:/Users/Lisa/Documents/LMU/5. Semester/Statistisches Praktikum/Analysen")
data <- read.csv("data.csv")
daten <- read_sav("Daten_RadAktiv_final_Kunde.sav")
data$X <- NULL
data$f01new <- NULL # damit funktioniert Regression nicht
data$f1801 <- NULL
data$f180201 <- NULL
data$f180202 <- NULL

data[sapply(data, is.integer)] <- lapply(data[sapply(data, is.integer)], as.factor)

data$f1601 <- daten$f1601 # wie viele personen im hh
data$f1602 <- daten$f1602
data$f20 <- daten$f20 # alter
data$f0204new <- NULL # damit funktionieren marginale Effekte nicht

data_NA <- na.omit(data)
data_NA$f0204new <- NULL

mod_full <- glm(f0201new ~ . , family = binomial, data = data)
summary(mod_full)
AIC(mod_full)

margin_full <- logitmfx(formula = f0201new ~ ., atmean = TRUE, data = data)
margin_full

# kommt das gleiche raus
mod_full_NA <- glm(f0201new ~ . , family = binomial, data = data_NA)
summary(mod_full_NA)
AIC(mod_full_NA)

# hier auch
anova(mod_full, mod_full_NA)

# Mit Interaktion wird AIC besser
mod_full_1 <- glm(f0201new ~ f15*f22 +., family = binomial, data = data)
summary(mod_full_1)
AIC(mod_full_1)

mod_final_1 <- glm(f0201new ~ f15*f22 + f0101 + f05 + f07 + f0801 + f0803 + f0807 + f0808 + 
                     f0810 + f0811 + f0812 + f0813 + f0814 + f0815 + f0818 + f0819 + 
                     f0821 + f0823 + f0824 + f0825 + f0827 + f0902 + f0903 + f1003 + 
                     f11 + f12 + f1603 + f180201 + f180202 + Mig + f0202new + 
                     f0203new + f20, family = binomial, data = data)
AIC(mod_final_1) # hier aic erhöht
### Interaktion Frage 8, nicht so gut
mod_full_2 <- glm(f0201new ~ f0803*f0822 +f0804*f0824 +., family = binomial, data = data)
summary(mod_full_2)
AIC(mod_full_1)

### Interaktion Frage 16 und Schicht mit Abschluss
mod_full_3 <- glm(f0201new ~ f1601*f1602 +., family = binomial, data = data, maxit = 200)
summary(mod_full_3)
AIC(mod_full_1)



### Interaktion von  Abschluss und Alter, Abschluss und Schicht, Anzahl der Personen in ^2
mod_full_4 <- glm(f0201new ~ f15*f20 + f15*f22 + I(f1601^2)+I(f1602^2)+., family = binomial, data = data)
summary(mod_full_4)
AIC(mod_full_4)

mod_final_3 <- glm(f0201new ~ f15*f20 + f15*f22 + I(f1601^2)+I(f1602^2)+ f0101 + f05 + f07 + f0801 + f0803 + f0807 + f0808 + 
                     f0810 + f0811 + f0812 + f0813 + f0814 + f0815 + f0818 + f0819 + 
                     f0821 + f0823 + f0824 + f0825 + f0827 + f0902 + f0903 + f1003 + 
                     f11 + f12 + f1603 + f180201 + f180202 + Mig + f0202new + 
                     f0203new + f20, family = binomial, data = data)
AIC(mod_final_3) # AIC schlechter

### Interaktion von Alter und Geschlecht, AIC schlechter
mod_full_5 <- glm(f0201new ~ f20*f12+., family = binomial, data = data)
summary(mod_full_5)
AIC(mod_full_5)

### Interaktion Alter und Abschluss
mod_full_6 <- glm(f0201new ~ f15*f20+., family = binomial, data = data)
summary(mod_full_6)
AIC(mod_full_6)

mod_final_6 <- glm(f0201new ~ f15*f20+ f0101 + f05 + f07 + f0801 + f0803 + f0807 + f0808 + 
                     f0810 + f0811 + f0812 + f0813 + f0814 + f0815 + f0818 + f0819 + 
                     f0821 + f0823 + f0824 + f0825 + f0827 + f0902 + f0903 + f1003 + 
                     f11 + f12 + f1603 + f180201 + f180202 + Mig + f0202new + 
                     f0203new + f20, family = binomial, data = data)
AIC(mod_final_6) #schlechter
### Interaktion Geschlecht und Abschluss
mod_full_7 <- glm(f0201new ~ f15*f12+., family = binomial, data = data)
summary(mod_full_7)
AIC(mod_full_7)

mod_final_7 <- glm(f0201new ~ f15*f12+f0101 + f05 + f07 + f0801 + f0803 + f0807 + f0808 + 
                     f0810 + f0811 + f0812 + f0813 + f0814 + f0815 + f0818 + f0819 + 
                     f0821 + f0823 + f0824 + f0825 + f0827 + f0902 + f0903 + f1003 + 
                     f11 + f12 + f1603 + f180201 + f180202 + Mig + f0202new + 
                     f0203new + f20, family = binomial, data = data)
AIC(mod_final_7) #schlechter
