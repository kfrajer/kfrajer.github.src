From kfrajer/hugo:v0.71.1
#WORKDIR /deployed/public/hugo

CMD ["--bind", "0.0.0.0", "--templateMetrics"]
ENTRYPOINT ["hugo", "server"]