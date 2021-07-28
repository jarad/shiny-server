theme_map    <- function() {
  theme_bw() +
    theme(
      axis.line         = element_blank(),
      axis.text.x       = element_blank(),
      axis.text.y       = element_blank(),
      axis.ticks        = element_blank(),
      axis.title.x      = element_blank(),
      axis.title.y      = element_blank(),
      panel.grid.major  = element_blank(),
      panel.grid.minor  = element_blank(),
      plot.background   = element_blank(),
      legend.position   = "bottom",
      legend.text.align = 0.5,
      legend.key.width  = unit(2, "cm")
    )
}