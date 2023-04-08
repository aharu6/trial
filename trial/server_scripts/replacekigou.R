kigou <- c("\\+","-","\\*","/","%","=",">","<","!","#","$","&","'","\\(","\\)","~","^","¥","|","@","`","\\[","\\]","\\{","\\}",";",":","・","_")
clfile() -> replacedt

for (b in 1:length(kigou)) {
  ifelse(grepl(pattern = b,replacedt),
         replacedt%>% mutate_all(~str_replace_all(.,"-","")) -> replacedt,
         replacedt->replacedt)
}
renderTable(replacedt)

