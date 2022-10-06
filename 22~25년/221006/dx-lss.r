#1. devtools 패키지를 설치하고, 로드합니다

install.packages("devtools")
library(devtools)


#2. dxlss2 패키지를 설치하고, 로드합니다

devtools::install_github("hogi76/dxlss2")
library(dxlss2)




#3. mtcars 데이터를 확인하고, oneshot_model을 적용합니다.

mtcars %>% head(10)
oneshot_model(mtcars, mpg)



#4. airquality데이터를 확인하고, oneshot_model을 적용합니다.

airquality %>% head(10)
oneshot_model(airquality, Ozone)


#5. mpg 데이터를 확인하고, oneshot_model을 적용합니다.

mpg %>% head(10)
oneshot_model(mpg, hwy)
