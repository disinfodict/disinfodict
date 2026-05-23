#install.packages("httr2")
require(httr2)

f <- function(url){
  print(url)
  Sys.sleep(2)
  resp <- 
    request(url) |> 
    req_headers(
      `User-Agent` = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:121.0) Gecko/20100101 Firefox/121.0",
      Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
      `Accept-Language` = "en-US,en;q=0.5",
      `Accept-Encoding` = "gzip, deflate, br",
      `Upgrade-Insecure-Requests` = "1",
      DNT = "1",
      `Sec-GPC` = "1",
    ) |> 
    req_perform()
  bod <- resp |> resp_body_string()
  lin <- strsplit(bod, '</sup></a></li>')[[1]]
  lin <- lin[-length(lin)]
  lin <- lin[-(1:(grep("All countries", lin)-1))]
  lin <- sub('(.*\\">)([ abcdefghijklmnopqrstuvwxyz]+)(<sup>)([01234567890]+)', '\\2:\\4', lin, ignore.case = TRUE)
  x <- do.call("rbind", lapply(strsplit(lin, ":"), function(x)data.frame(country=x[1], companies=as.integer(x[2]))))
  y <- x$companies
  names(y) <- x$country
  y
}

urls <- c(
    continue="https://leave-russia.org/?flt%5B147%5D%5Beq%5D%5B0%5D=9057"
  , pause="https://leave-russia.org/?flt%5B147%5D%5Beq%5D%5B%5D=9058"
  , scaleback="https://leave-russia.org/?flt%5B147%5D%5Beq%5D%5B%5D=9059"
  , suspend="https://leave-russia.org/?flt%5B147%5D%5Beq%5D%5B%5D=9060"
  , withdraw="https://leave-russia.org/?flt%5B147%5D%5Beq%5D%5B%5D=9062"
  , exited="https://leave-russia.org/?flt%5B147%5D%5Beq%5D%5B%5D=9061"
  )

colors <- c(
  continue="red"
, pause="orange"
, scaleback="yellow"
, suspend="white"
, withdraw="black"
, exited="green"
)

l <- lapply(urls, f)
countries <- sort(unique(unlist(sapply(l, function(x)names(x)))))
d <- data.frame(row.names = countries)
for (nam in names(l)){
  ll <- l[[nam]]
  d[[nam]] <- 0
  d[names(ll), nam] <- as.vector(ll)
}
rownames(d)[rownames(d) == "United Kingdom"] <- "UK"
x <- d[order(d$continue, decreasing=TRUE),]
y <- x[12:1,]
pct <- paste0(round(100*y$continue/rowSums(y)), "%")
space <- 0.2

round(100*sum(x$continue) /  sum(as.matrix(x)))

png("economy/leave-russia.png", 1024, 1024)
par(mar=c(5,8,3,1)+0.1, cex=2)
barplot(t(as.matrix(y))
        , horiz=TRUE
        , space=space
        , names.arg=rownames(y)
        , las=1
        , col=colors
        , legend.text = colnames(y)
        , args.legend = list(x=800, y=10)
        , main="Countries with most companies continuing in Russia"
        , xlab=paste0("number of companies from leave-russia.org as of ", Sys.Date())
)
text(y$continue/2, seq_along(y$continue)*(1+space)-(0.5), labels = paste0(round(100*y$continue/rowSums(y)), "%"), cex=0.7)
dev.off()

