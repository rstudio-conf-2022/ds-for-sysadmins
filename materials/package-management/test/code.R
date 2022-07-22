library(ggplot2)

# Jittered points
ggplot(mpg, aes(cty, hwy)) +
  geom_jitter(size = 0.5, width = 0.5)
