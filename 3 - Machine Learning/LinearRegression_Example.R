## Load in data
data(mtcars)

## Define X matrix
X <- as.matrix(cbind(1,
                     mtcars$cyl,
                     mtcars$hp))

## Define y matrix
y <- as.matrix(mtcars$mpg)

## Solve for beta_hat
beta_hat <- solve(t(X)%*%X)%*%t(X)%*%y


## Fit the same data using lm
fit <- lm(mpg ~ cyl + hp,
          data = mtcars)

fit$coefficients
