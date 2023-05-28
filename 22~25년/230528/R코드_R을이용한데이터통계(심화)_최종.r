# R을 이용한 데이터 통계(심화)

setwd('c:/data/exam_r')
getwd()

##############
# 01 R의 이해#
##############

# 연산자 (+, -, *, /, ^, != 등)

# 사칙 연산
5+3
5-3
5*3
10/2

# 몫(%/%), 나머지(%%)
50 %/% 10
35 %% 6

# 제곱, 제곱근, 지수, 로그
5**4 ; 5^4
sqrt(16)
exp(1) ; exp(3)
log(exp(3))

# 논리 연산자 ==, !=
15 == 16
15 = 16
16 != 19

# And, Or
x = c(1:20)
x[x>5 & x < 15]
x[x>5 | x < 15]

# 연습 문제 
5^2+4^3-log(23)

x = c(1:16)
x[x%%2 == 1]

y = c(1:100)
y[y >= 34 & y < 76]


# 조건문 (if)
if(5>6) {
  print("Yes") 
} else {
  print("No")
}
ifelse(5>6, "Yes", "No")

# 반복문 (for) 
x = c(1:10)
for(i in 1:10) {
  x[i] = x[i] + i
}
x

# 조건문, 반복문 연습문제 
x = c(1:20) 
for(i in 1:20) {
  if(x[i]%%2==0) {
    x[i] = x[i]/2
  } else {
    x[i] = x[i]*2
  }
}
x

for(i in 1:9) {
  print(5*i)
}


# 행/열 데이터 합치기 (rbind, cbind)

company.A = read.csv("회사 A.csv")
company.B = read.csv("회사 B.csv")
company.C = read.csv("회사 C.csv")

company.all = rbind(company.A, company.B, company.C)
company.all

first.week = c(5.19, 5.53, 4.78, 5.44, 4.47, 4.78, 4.26, 5.70, 4.40, 5.64)
second.week = c(5.57, 5.11, 5.76, 5.65, 4.99, 5.25, 7.00, 5.20, 5.30, 4.91) 
third.week = c(8.73, 5.01, 7.59, 4.73, 4.93, 5.19, 6.77, 5.66, 6.48, 5.20)

All.week = cbind(first.week, second.week, third.week)
All.week

# sqldf 패키지 설치 및 라이브러리 호출

install.packages(sqldf)
library(sqldf)


# SQL을 위한 데이터 불러오기

data1 <- read.csv("data_handling_sql1.csv", fileEncoding = "euc-kr")
head(data1)
data2 <- read.csv("data_handling_sql2.csv", fileEncoding = "euc-kr")
head(data2)
rm(ex1)

# 1. 테이블 결합

# left join 실습
ex1_1 <- sqldf(" select a.직원ID,
                        a.부서,
                        a.직급,
                        a.지각횟수,
                        a.결근횟수,
                        a.업무성과평점,
                        b.토익점수
                  from data2 as a
                  left outer join data1 as b
                    on a.직원ID = b.직원ID
              ")

# inner join 실습
ex1_2 <- sqldf(" select a.직원ID,
                        a.부서,
                        a.직급,
                        a.지각횟수,
                        a.결근횟수,
                        a.업무성과평점,
                        b.토익점수
                  from data2 as a
                  inner join data1 as b
                     on a.직원ID = b.직원ID
              ")

# full join 실습
ex1_3 <- sqldf(" select a.직원ID,
                        a.부서,
                        a.직급,
                        a.지각횟수,
                        a.결근횟수,
                        a.업무성과평점,
                        b.토익점수
                  from data2 as a
                  full outer join data1 as b
                    on a.직원ID = b.직원ID
              ")


# 2. 부분집합 추출
# select 절에 사용자가 필요한 변수 입력

# left join을 통해 결합한 ex1_1 테이블을 sql_data로 지정
sql_data <- ex1_1

# 직원ID만 추출
ex2_1 <- sqldf(" select 직원ID
                 from sql_data
              ")
head(ex2_1)

# 직원ID, 부서, 직급, 토익점수 추출
ex2_2 <- sqldf(" select 직원ID, 부서, 직급, 토익점수
                 from sql_data
              ")
head(ex2_2)

# 모든 변수 추출
ex2_3 <- sqldf(" select *
                 from sql_data
              ")
head(ex2_3)



# 3. 부분집합 추출
# where 절에 사용자가 원하는 조건에 따라 데이터 추출

# 지각횟수가 0인 직원 추출
ex3_1 <- sqldf(" select *
                   from sql_data
                  where 지각횟수 = 0
              ")
head(ex3_1)

# 지각횟수가 3회 이상인 직원 추출
ex3_2 <- sqldf(" select *
                   from sql_data
                  where 지각횟수 >= 3
              ")
head(ex3_2)

# 지각횟수 및 결근횟수가 모두 0회인 직원 추출
ex3_3 <- sqldf(" select *
                   from sql_data
                  where 지각횟수 = 0 and 
                        결근횟수 = 0
              ")
head(ex3_3)

# 업무성과 평점이 5점 이상이거나 토익점수가 800점 이상인 직원 추출
ex3_4 <- sqldf(" select *
                   from sql_data
                  where 업무성과평점 >= 5 or 
                        토익점수 >= 800
              ")
head(ex3_4)

# 4. sql 구문을 통한 결측치 처리
colSums(is.na(sql_data)) # sql_data 데이터의 결측치 확인

# 토익점수가 결측치인 직원 추출
ex4_1 <- sqldf(" select *
                   from sql_data
                  where 토익점수 is null 
              ")
head(ex4_1)

# 토익점수가 결측치가 아닌 직원 추출
ex4_2 <- sqldf(" select *
                   from sql_data
                  where 토익점수 is not null 
              ")
head(ex4_2)



# 5. sql을 이용한 파생변수 생성 

# 근태점수 생성 로직 : 100 - (결근횟수+(지각횟수/3))*5
# 주의(!!) : 생성 로직을 이용하여 파생변수를 생성할 때에는 정수(integer)
# 형태인지 실수(numeric) 형태인지 지정해야 함
# 예를 들어, 실수 형태라면 10/3이 아닌 10.0 / 3.0 과 같은 식으로 지정 필요

# 근태 점수 생성
ex5_1 <- sqldf(" select *,
                        100 - (결근횟수+(지각횟수/3.0))*5.0 as 근태점수
                   from sql_data
              ")
head(ex5_1)
str(ex5_1)

# 근태평점 생성(값 범위로 코드 지정)
ex5_2 <- sqldf(" select *,
                        case when 근태점수 >=0 and 근태점수 <= 20   then 1
                             when 근태점수 > 20 and 근태점수 <= 40  then 2
                             when 근태점수 > 40 and 근태점수 <= 60  then 3
                             when 근태점수 > 60 and 근태점수 <= 80  then 4
                             when 근태점수 > 80 and 근태점수 <= 100 then 5
                             else null end as 근태평점
                   from ex5_1
              ")
head(ex5_2)

# 토익평점 생성(값 범위로 코드 지정)
ex5_3 <- sqldf(" select *,
                        case when 토익점수 <= 600                    then 1
                             when 토익점수 > 600 and 토익점수 <= 800 then 2
                             when 토익점수 > 800                     then 3
                             else 0 end as 토익평점
                   from ex5_2
              ")
head(ex5_3)

# 총 평가점수 생성
# 총 평가점수 = 업무성과 + 근태평점 + 토익평점
ex5_4 <- sqldf(" select *,
                        업무성과평점 + 근태평점 + 토익평점 as 총평가점수
                   from ex5_3
              ")
head(ex5_4)

#############
#02 가설검정# 
#############

# 1표본 t-검정(모수적 검정)
# 데이터 불러오기

Tuna.Can <- read.csv('참치캔.csv', fileEncoding = 'euc-kr')
Tuna.Can

# 정규성 검정
install.packages('nortest') # Anderson-Darling 검정을 위한 패키지 설치
library(nortest)
ad.test(Tuna.Can$참치캔) # AD 정규성 검정

# t.test() 함수 사용
# t.test(검정할 자료, mu=귀무가설에 주어진 평균, alternative=양측, 단측)
t.test(Tuna.Can, mu=150, alternative = "two.sided") # H1 : 평균이 150이 아니다

# t.test(Tuna.Can, mu=150, alternative = "less") # H1 : 평균이 150보다 작다
# t.test(Tuna.Can, mu=150, alternative = "greater") # H1 : 평균이 150보다 크다

# 1 sample Wilcoxon Test(비모수적 검정)

# 데이터 불러오기
antacid <- read.csv('antacid.csv')
head(antacid)

# 정확검정을 위한 패키지 설치
install.packages('exactRankTests')
library(exactRankTests) 

wilcox.test(antacid$time, mu=12, exact = F) # 정확검정을 적용하지 않음
wilcox.exact(antacid$time, mu=12) # 정확검정을 적용

# 독립 2표본 T-검정(모수적 검정)

Energy <- read.csv("에너지 소비량.csv", header = T)
head(Energy)

# 통풍조절기 별로 데이터 추출하기
Energy.Elec = subset(Energy, Ventilation.Machine==1) # 전기 통풍조절기 데이터 추출
Energy.Heat = subset(Energy, Ventilation.Machine==2) # 열 통풍조절기 데이터 추출

# 정규성 검정 : 정규확률도
qqnorm(Energy.Elec$Energy.Consume) ; qqline(Energy.Elec$Energy.Consume)  # 전기 정규확률도 # qqnorm(): 정규확률도
qqnorm(Energy.Heat$Energy.Consume) ; qqline(Energy.Heat$Energy.Consume)  # 열 정규확률도

# ggplot을 이용한 정규확률도
ggplot(Energy, aes(sample = Energy.Consume, color = Ventilation.Machine)) +
  geom_qq() + geom_qq_line() +
  facet_grid(.~Ventilation.Machine)

# 행을 분할하지 않고 정규성 검정 수행
qqnorm(Energy$Energy.Consume[Energy$Ventilation.Machine == 1])
qqnorm(Energy$Energy.Consume[Energy$Ventilation.Machine == 2])

# 행을 분할하지 않고 정규성 검정 수행
ad.test(Energy$Energy.Consume[Energy$Ventilation.Machine == 1]) # 전기
ad.test(Energy$Energy.Consume[Energy$Ventilation.Machine == 2]) # 열

# 행을 분할한 정규성 검정
ad.test(Energy.Elec$Energy.Consume) # 전기 정규성 검정
ad.test(Energy.Heat$Energy.Consume) # 열 정규성 검정

# 분산의 동일성 검정
var.test(Energy.Elec$Energy.Consume, Energy.Heat$Energy.Consume)  # var.test(그룹1 자료, 그룹2 자료)

# 2-표본 t-검정(모수적 검정)
t.test(Energy.Elec$Energy.Consume, Energy.Heat$Energy.Consume, var.equal=TRUE) # t.test(그룹1 자료, 그룹2 자료, var.equal = TRUE or FALSE)

# 2-표본 검정(비모수적 검정, Mann-Whitney U-test)
# 데이터 불러오기

mw <- read.csv('mwtest.csv', fileEncoding = 'euc-kr')
head(mw)
View(mw)

# 데이터 개수가 매우 작으므로 비모수 검정 수행
# 데이터 유형 변경
str(mw)
mw$group <- as.factor(mw$group)
attach(mw)
# detach(mw) attach를 해제하는 방법
boxplot(score~group)
wilcox.test(score~group, exact = F)
wilcox.exact(score~group)

# 쌍체 t 검정(모수적 방법, 대응)

# 데이터 불러오기

shoes <- read.csv('shoes.csv')
library(dplyr)

# t.test(그룹1 자료, 그룹2 자료, paired=TRUE) 
t.test(shoes$mt1, shoes$mt2, paired=TRUE)

# 1표본 t 검정과 동일
shoes1 <- mutate(shoes, diff = mt1 - mt2) # dplyr 함수 사용

shoes$diff <- shoes$mt1 - shoes$mt2 # 내장함수 사용

# 2 표본 wilcoxon Signed Rank test
# 데이터 불러오기

pair <- read.csv('pairedws.csv')
head(pair)
wilcox.test(pair$pre, pair$post, paired=TRUE, exact = F)
wilcox.exact(pair$pre, pair$post, paired=TRUE)

### 분산분석 ###

# 기계1, 기계2 데이터 불러오기

machine1 = read.csv("기계1.csv", header=T) # 기계1 데이터 불러오기
machine2 = read.csv("기계2.csv", header=T) # 기계2 데이터 불러오기

machine1$Company <- as.factor(machine1$Company) # Company 변수 범주형 변환

# 표본 크기가 작아 Anderson-Darling 검정 불가. Shapiro-Wilk 검정으로 정규성 확인 
# machine2 데이터 사용
shapiro.test(machine2$Company.A)
shapiro.test(machine2$Company.B)
shapiro.test(machine2$Company.C)

# 등분산 검정
install.packages("car")
library(car)

# leveneTest() 함수 사용 
# leveneTest(y변수~그룹 변수, data=자료)
leveneTest(Product~Company, data=machine1)   # y값이 한 열인 데이터

# 기계를 생산하는 회사에 따라 생산량에 차이가 있을까?(일원 분산 분석 수행)

anova <- aov(Product~Company, data=machine1) # aov(y변수~그룹변수, data=자료)
summary(anova)                              # 분산분석표 및 p-값 확인

# 분산분석표 확인

anova.table <- anova(anova) # anova(분산분석 결과)
anova.table

par(mfrow=c(2,2))
plot(anova)


# 어느 회사 기계의 성능이 가장 우수할까?(다중비교, 사후검정)

tukey.result = TukeyHSD(anova) # Tukey의 쌍별 비교 (TukeyHSD() 함수 사용)
tukey.result

plot(tukey.result) # 그룹 별 비교 그래프 확인

mean(machine2$Company.A)  # 회사 A 평균
mean(machine2$Company.B)  # 회사 B 평균
mean(machine2$Company.C)  # 회사 C 평균


## Kruskal-Wallis Test
# 데이터 불러오기
kw <- read.csv('kwtest.csv')
View(kw)
model <- kruskal.test(kw$score, kw$group)

# 다중비교(사후검정)
install.packages('pgirmess')
library(pgirmess)

kruskalmc(kw$score, kw$group)

##############
# 03 회귀분석#
##############

# 산점도와 상관분석 실습
# 데이터 불러오기
scatter.plot <- read.csv("작업속도와 결함률.csv")

# 데이터 확인
head(scatter.plot)
str(scatter.plot)

# 산점도 그리기

# 1. 작업속도와 결함률 간의 관계는 어떠한가?
a1 <- ggplot(scatter.plot, aes(x = Work.Velocity, 
                               y = Error.Rate)) +
  geom_point()
a1

# 2. 작업속도와 결함률 간의 상관관계 확인
a2 <- cor.test(scatter.plot$Work.Velocity, 
               scatter.plot$Error.Rate)
a2

# 3. 회귀직선 추가
a3 <- ggplot(scatter.plot, aes(x = Work.Velocity, 
                               y = Error.Rate)) +
  geom_point() +
  stat_smooth(method = 'lm')   # 회귀직선 추가
a3

# 상관분석(Spearman)
cor.test(scatter.plot$Work.Velocity, scatter.plot$Error.Rate)
cor.test(scatter.plot$Work.Velocity, scatter.plot$Error.Rate, method="spearman", exact = FALSE)
cor(Work.Velocity, Error.Rate, method = 'spearman') # spearman 상관계수만 확인하기

# 단순회귀분석

# 광고비 데이터 불러오기
advertising <- read.csv("광고비.csv", header=T)
advertising

# 적합선 그림
a1 <- ggplot(advertising, aes(x = Cost,
                              y = Sales)) +
  geom_point(color = "blue")
a1

# 회귀직선 추가
a2 <- ggplot(advertising, aes(x = Cost,
                              y = Sales)) +
  geom_point(color = "blue") +
  stat_smooth(method = 'lm', se = FALSE)    # 회귀직선 추가
a2


# 단순 회귀 분석 적합

reg <- lm(Sales~Cost, data=advertising) # lm(y변수~x변수, data=자료)
reg

summary(reg)                   # 요약통계량 및 계수 검정

# 신규 데이터 예측

new_cost_data = data.frame(Cost=50)  # predict(모형, newdata=새로운 자료) -> 새로운 데이터프레임

# 예측값, 신뢰구간
predict(reg, new_cost_data, interval = "confidence")  # 신뢰구간 예측하기

# 예측값, 예측구간
predict(reg, new_cost_data, interval = "prediction") # 예측구간 예측하기

# 다중회귀분석

# 데이터 불러오기
survival <- read.csv("survival.csv")

# 데이터 확인
head(survival)
str(survival)

# 모든 변수 상관계수 확인
cor(survival)

# 상관행렬 생성
sur_cor <- cor(survival)
round(sur_cor, 2) # 소수점 둘째 자리까지 출력

# 상관행렬 히트맵 생성
install.packages("corrplot")
library(corrplot)

corrplot(sur_cor) # 상관행렬 히트맵

# 다중회귀모형 구축
sur.fit <- lm(Y ~., data = survival)
summary(sur.fit)

# 간장기능 검사점수(X4) 변수를 제외하고 재구축
sur.fit02 <- lm(Y ~ X1 + X2 + X3, data = survival)
summary(sur.fit02)

# 다중공선성 확인
install.packages("car") # car 패키지 설치
library(car)

vif(sur.fit02) # 간장기능 검사점수(X4) 제외한 모델 vif 확인

# 잔차그림 확인
plot(sur.fit02, which = 1, col=c("blue")) # Residuals vs Fitted Plot
plot(sur.fit02, which = 2, col=c("red")) # Normal Q–Q (quantile-quantile) Plot
plot(sur.fit02, which = 3, col=c("blue")) # Scale-Location
plot(sur.fit02, which = 5, col=c("blue")) # Residuals vs Leverage

par(mfrow=c(2,2))
plot(sur.fit02)

# Y값을 상용로그(밑이 10인 로그)로 변환
library(dplyr)
survival2 <- mutate(survival, Y2 = log(Y, base = 10))
head(survival2)

# 로그변환된 Y값으로 다중회귀모형 재구축
sur.fit03 <- lm(Y2 ~ X1 + X2 + X3 + X4, data = survival2)
summary(sur.fit03)

# 간장기능 검사점수(X4)가 유의하지 않으므로 모형에서 제외
sur.fit04 <- lm(Y2 ~ X1 + X2 + X3, data = survival2)
summary(sur.fit04)

# 잔차그림 최종 확인
plot(sur.fit04, which = 1, col=c("blue")) # Residuals vs Fitted Plot
plot(sur.fit04, which = 3, col=c("blue")) # Scale-Location


### 표준화 계수 ###
lm(data.frame(scale(sur.fit04$model)))

#install.packages("lm.beta")
library(lm.beta)
lm.beta(sur.fit04)

# 로지스틱 회귀분석
# 데이터 불러오기

diabetes = read.csv("diabetes.csv")
str(diabetes)

# sex부터 BMI까지 범주형 변수로 지정 입력해야 하므로 데이터 유형을 모두 factor로 변환 
# x1은 연속형 데이터이므로 변환할 필요 없음

diabetes$x2 = factor(diabetes$x2)
diabetes$x3 = factor(diabetes$x3)
diabetes$x4 = factor(diabetes$x4)
diabetes$x5 = factor(diabetes$x5)
diabetes$x6 = factor(diabetes$x6)
diabetes$x7 = factor(diabetes$x7)
diabetes$x8 = factor(diabetes$x8)

str(diabetes)

# 완전 모형(Full Model) 적합(이항로지스틱 회귀분석)
diabetes.logis = glm(y~., data = diabetes, family="binomial")
summary(diabetes.logis) # 분석 결과 확인

exp(-0.08924) # Odds Ratio 확인

# 성별 변수(x2) 제거
diabetes.logis2 = glm(y ~ x1 + x3 + x4 + x5 + x6 + x7 + x8, 
                      data=diabetes, family="binomial")
summary(diabetes.logis2)

# 고혈압 의사 진단 여부 변수(x7) 제거
diabetes.logis3 = glm(y ~ x1 + x3 + x4 + x5 + x6 + x8, 
                      data=diabetes, family="binomial")
summary(diabetes.logis3)

# 음주 여부 변수(x5) 제거 
diabetes.logis4 = glm(y ~ x1 + x3 + x4 + x6 + x8, 
                      data=diabetes, family="binomial")
summary(diabetes.logis4)

# 오즈비 (Odds Ratio)
exp(coef(diabetes.logis4))

# Hosmer-Lemeshow Test

# 적합도 검정(Hosmer-Lemeshow)을 위한 패키지 설치(ResourceSelection)

install.packages("ResourceSelection")
library(ResourceSelection)

hoslem.test(diabetes.logis4$y, diabetes.logis4$fitted.values) # hoslem.test(Y, Yhat)

##############
# 04 생존분석#
##############

# 생존분석(Survival Analysis)에 필요한 패키지 설치
# survival
# survminer
# dplyr(데이터 전처리)

# 패키지 설치

install.packages('survival')
install.packages('survminer')

library(survival)
library(survminer)
library(dplyr)

# survival 패키지에서 제공하는 데이터세트 확인
data(package = 'survival')

# lung 데이터세트 활용

str(lung)
dim(lung)
# time(생존시간(일))
# status(환자상태, 중도절단 = 1, 사망 = 2)
# sex(성별, 남성 = 1, 여성 = 2)

# ggplot을 이용하여 연령 분포 확인
ggplot(lung, aes(x = age)) +
  geom_histogram(bins = 15,
                 fill = 'skyblue',
                 color = 'black')

# 60대 기준으로 그룹 분할
lung <- lung %>% mutate(age_group = ifelse(age > 60, "above60", "under60"))

# 그룹 별 데이터 개수 확인
table(lung$age_group)
nrow(filter(lung, age_group == 'above60')) # 60대 이상 환자 수 확인
nrow(filter(lung, age_group == 'under60')) # 60대 미만 환자 수 확인

# 그룹 분할
lung[lung$age_group == "above60", ]

# 데이터 유형 변경 및 범주(수준)명 변경
lung$sex <- factor(lung$sex,
                   levels = c(1, 2),
                   labels = c('male', 'female'))

# 성별에 따른 연령 분포 확인(참고)
ggplot(lung, aes(x = age, fill = sex)) +
  geom_histogram(position = 'identity',
                 alpha = 0.5,
                 bins = 15,
                 color = 'black')

# 중도 절단 표시
surv_object <- Surv(time = lung$time, event = lung$status)
surv_object # + 표시는 중도절단을 의미

# survfit 함수를 이용한 Kaplan-Meier 곡선 적합
# 그룹을 고려하지 않은 전체 kaplan-Meier 곡선 적합

w_fit <- survfit(surv_object ~ 1, data = lung)
w_fit
names(w_fit) # 분석 결과 지표 확인

# 분석결과 정리를 위한 데이터프레임으로의 변환
w_fit.df <- data.frame(time=w_fit$time,
                       n.risk=w_fit$n.risk,
                       n.event=w_fit$n.event,
                       n.censor=w_fit$n.censor,
                       surv=w_fit$surv)
head(w_fit.df)

# 6개월, 12개월 후의 생존 확률 추정
summary(w_fit, times = c(180, 360)) # 원하는 time 입력하여 확인

# 전체 70%가 사망할 시간
# 전체 50%가 사망할 시간
# 전체 30%가 사망할 시간
quantile(w_fit, probs = 1-c(0.7, 0.5, 0.3)) 


# 연령대에 따른 생존 비교
age_fit <- survfit(surv_object ~ age_group, data = lung)
summary(age_fit)

# 성별에 따른 생존 비교
sex_fit <- survfit(surv_object ~ sex, data = lung)
sex_fit

summary(sex_fit)

# 생존분석 결과 시각화
# 그래프 내 수직바는 중도절단을 의미
# 전체 생존 그림
ggsurvplot(w_fit, pval = T, conf.int = TRUE,
           risk.table = 'absolute', risk.table.col = 'strata',
           linetype = 'strata', surv.median.line = 'hv',
           ggtheme=theme_bw(), palette = c('royalblue', 'salmon')) 

# 성별(sex)에 따른 생존 그림
ggsurvplot(sex_fit, conf.int = TRUE, pval = TRUE,
           risk.table = 'abs_pct', risk.table.col = 'strata',
           linetype = 'strata',  surv.median.line = 'hv',
           conf.int.style ='step', xlab = "Days", break.time.by = 180,
           risk.table.fontsize = 3.5, risk.table.y.text = FALSE,
           ncensor.plot = T,
           legend.labs = c("Male", "Female"),
           ggtheme=theme_bw(), palette = c('royalblue', 'salmon'))

# risk.table = "abs_pct" = 생존자를 수와 비율 동시에 표시, "absolute" = 수만 표시
# risk.table.col = 테이블의 색상을 집단별로 구분하여 표시
# linetype = 선의 유형을 선택
# surv.median.line = 중위수에 해당하는 부분을 선으로 표시
# conf.int.style = 신뢰구간을 선으로 표시 "step" = 점선으로 표시, "ribbon" = 음영으로 표시
# xlab = x축 제목
# break.time.by = x축의 간격 설정(예: 180)
# risk.table.fontsize = 위험표의 글자 크기 설정
# risk.table.y.text = F -> 위험표의 범례를 텍스트없이 막대로 표시
# ncensor.plot = TRUE -> 중도절단표 표시
# legend.labs = 범례의 이름 설정
# legend.title = 범례의 제목 설정
# ggtheme=theme_light 테마 설정
# xlim = c(0, 600) 0부터 600시간까지의 x축에 표시
# fun = 'event' 누적 생존함수
# fun = 'cumhaz' 누적 위험함수

# 끝쪽 시간의 신뢰구간이 커지고 겹치는 이유는 제대로된 결과를 얻지 못하는 이유가 큼

ggsurvplot(sex_fit, pval = T, censor = FALSE,
           xlab = 'Days',
           ylab = 'Survival Probability for Sex') # 성별(sex)에 따른 생존 그림)

# 집단별 결과 확인
summary(sex_fit)$table
summary(age_fit)$table
summary(sex_fit, times = c(180, 360))

# surv_summary 함수 사용
sex_summary <- surv_summary(sex_fit, data = lung)
head(sex_summary)
# 분석 요약
attr(sex_summary, "table")

# 로그 순위 검정(Log Rank Test)
# 성별에 따라 생존 시간에 차이가 있는지(카이제곱 검정)

survdiff(surv_object ~ sex, data = lung)

# 다중 집단의 kaplan-Meier 추정 방법
# colon(대장암) 데이터 사용

str(colon)
View(colon)

# 사망 데이터만 별도로 추출(etype = 2)하여 데이터세트 생성
colon_death <- colon[colon$etype == 2, ]
head(colon_death)

# 성별, 종양 분화상태의 데이터 유형 변경 및 수준 설정

colon_death$sex <- factor(colon_death$sex,
                          levels = c(0, 1),
                          labels = c('female', 'male'))

colon_death$differ <- factor(colon_death$differ,
                          levels = c(1, 2, 3),
                          labels = c('well', 'moderate','poor'))

# 성별(sex), 치료법(rx), 종양 분화상태(differ)에 따른 생존함수 추정
m_fit <- survfit(Surv(time, status) ~ sex + rx + differ, data = colon_death)
m_fit

# 생존 곡선 추정(성별, 치료법, 종양 분화상태)
# 성별 2수준, 치료법 3수준, 종양분화 상태 3수준 2*3*3 = 18개의 곡선 추정
ggsurvplot(m_fit, conf.int = TRUE, 
           conf.int.style = "step",
           ggtheme = theme_bw())

# 그래프 편집

ggsurv <- ggsurvplot(m_fit, conf.int = TRUE, 
                     conf.int.style = "step",
                     ggtheme = theme_bw())

ggsurv$plot + theme_bw() +
  theme(legend.position = 'right', legend.title = element_blank()) +
  facet_grid(rx ~ differ, labeller = label_both)


# Cox proportional hazard model(콕스 비례위험 모델)
# Hazard Ratio(HR)은 상대적 위험도(HR>1 : 사망위험 증가, HR<1 사망위험감소)

# ggsurvplot

# 콕스 비례위험 모델 적합
# lung(폐암) 데이터 활용
# 데이터 전처리

lung$sex <- factor(lung$sex, levels = c(1, 2),
                   labels = c('male','female'))

# 중도절단을 적용한 종속변수 생성
surv_cox <- Surv(time=lung$time, event = lung$status)
surv_cox

# 콕스 회귀분석 추정(연령(age), 성별(sex), 일상생활능력(ph.ecog))
# ph.ecog 1~5 (클수록 상태가 좋지 않음)
cox <- coxph(surv_cox ~ age + sex + ph.ecog,
             data = lung)
summary(cox)

# 분석 결과를 시각적으로 표시
ggforest(cox, data = lung)

# 생존 함수 추정
cox_fit <- survfit(cox, data = lung)
cox_fit
summary(cox_fit)

# 생존 곡선 작성
ggsurvplot(cox_fit, palette = "cornflowerblue",
           ggtheme = theme_minimal(),
           legend = "none",
           xlab = "Days",
           ylab = "Overall Survival Probability")

# 연령과 일상 생활능력을 평균값으로 고정하기 위한 데이터 전처리
sex.df <- with(lung, data.frame(sex = c('male','female'),
                                age = rep(mean(age, na.rm=TRUE)),
                                ph.ecog=rep(mean(ph.ecog, na.rm=TRUE) )))
sex.df

# 새로운 데이터 프레임을 예측하기 위한 객체 생성
sex.fit <- survfit(cox, newdata = sex.df, data = lung)
# 생존함수 작성
ggsurvplot(sex.fit, conf.int = FALSE,
           ggtheme = theme_minimal())

# ph.ecog(생활변화) 값의 범위 확인
range(lung$ph.ecog, na.rm=TRUE)

# ph.ecog(일상 생활능력)의 곡선 확인
# 성별(sex)와 연령(age)을 고정하고 곡선 확인
ph.df <- with(lung, data.frame(sex = 'male',
                                age = rep(mean(age, na.rm=TRUE) ),
                                ph.ecog=c(0, 1, 2, 3)))
ph.df

ph.fit <- survfit(cox, newdata = ph.df, data = lung)

ggsurvplot(ph.fit, conf.int = FALSE,
           ggtheme = theme_minimal(),
           legend.labs=c(0:3))

# 비례 위험 가정 충족 여부
# 잔차와 시간 간의 상관관계를 계산하여 통계적으로 유의한 지 확인

# 비례 위험 가정 충족 여부 분석
cox.zph(cox)

write.csv(ovarian, file = 'ovarian.csv', row.names = 'TRUE') # 데이터세트 CSV 파일로 저장
