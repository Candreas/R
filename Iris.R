#library(greta)
#library (causact)
#library("ggplot2")

print(iris)
print(iris$Species[c(1, 41)] )
ggplot(data = iris) +
   geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, color=Species))

# data
x <- as_data(iris$Petal.Length)
y <- as_data(iris$Sepal.Length)

# variables and priors
int <- normal(0, 1)

coef <- normal(0, 3)
sd <- student(3, 0, 1, truncation = c(0, Inf))

# operations
mean <- int + coef * x
 
print(mean)

# likelihood
distribution(y) <- normal(mean, sd)

# defining the model
m <- model(int, coef, sd)
model(m)
# plotting
plot(m)

# sampling
draws <- mcmc(m, n_samples = 1000)