library(tidyverse)

string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'

string2
writeLines(string2)

string3 <- "This is a two-line string.\nSecond line."
string3
writeLines(string3)

string4 <- "This is a string with the \t tab"
string4
writeLines(string4)

# Длина строки
x <- c("a", "R for data science", NA)
str_length(x)
nchar(x)

# Объединение строк
str_c("x", "y")
str_c("x", "y", "z")

str_c("x", "y", sep = ", ")

str_c("prefix-", c("a", "b", "c"), "-suffix")

str_c(c("x", "y", "z"), collapse = ", ")

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

(x <- str_to_lower(x))
str_to_upper(x)

# Простое регулярное выражение
str_view(x, "an")
str_view(x, ".a.")

# Регулярные выражения передаются функциям в виде строки
dot <- "\\."
writeLines(dot)

# Для использования \ в регулярных выражениях, в R используется \\
str_view(c("abc", "a.c", "bef"), "a\\.c")

# Привязка к началу и концу строки
str_view(x, "^a")
str_view(x, "a$")

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")


#--- Самостоятельно --------------------------------------------------#
length(words)
head(words)

# Напишите регулярные выражения для поиска слов, которые
# 1. Начинаются c x


# 2. Заканчиваются на y


# 3. Содержат строго 3 символа


# 4. Содержат 7 символов и более


#---------------------------------------------------------------------#

# Классы символов и альтернативы
# \d: matches any digit.
# \s: matches any whitespace (e.g. space, tab, newline).
# [abc]: matches a, b, or c.
# [^abc]: matches anything except a, b, or c.

x <- c("apple", "banana", "pear")
str_view(x, "[abc][anp]")
str_view(x, "[^abc][anp]")

# Можно использовать для поиска специальных символов регулярных выражений
str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")
str_view(c("abc", "a.c", "a*c", "a c"), ".[*]c")
str_view(c("abc", "a.c", "a*c", "a c"), "a[ ]")

str_view(c("grey", "gray"), "gr(e|a)y")

#--- Самостоятельно --------------------------------------------------#
# Напишите регулярные выражения для поиска слов, которые
# 1. Начинаются с гласной буквы


# 2. Содержат только согласные буквы


# 3. Заканчиваются на "ed", но не на "eed"
str_view(w, "ed$", match = T)

# 4. Заканчиваются на "ing", но не на "ise"


#---------------------------------------------------------------------#

# Повторение паттерна
# ?: 0 or 1
# +: 1 or more
# *: 0 or more

str_view(w, "lond?", match = T)
str_view(w, "s+", match = T)

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "C+")
str_view(x, 'C[LX]+')

# {n}: exactly n
# {n,}: n or more
# {,m}: at most m
# {n,m}: between n and m

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")

#--- Самостоятельно --------------------------------------------------#
# Напишите регулярные выражения для поиска слов, которые
# 1. Начинаются с трех согласных


# 2. Содержат три или более гласных подряд


# 3. Содержат две или более пары гласная-согласная подряд


#---------------------------------------------------------------------#

# Группировка и использование ссылок
str_view(fruit, "(..)\\1", match = TRUE)

#--- Самостоятельно --------------------------------------------------#
# Примените к набору слов следующие регулярные выражения и разберитесь с их смыслом:
# - "(.)\\1\\1"
# - "(.)(.)\\2\\1"
# - "(..)\\1"
# - "(.).\\1.\\1"
# - "(.)(.)(.).*\\3\\2\\1"



# Напишите регулярные выражения для поиска слов, которые
# 1. Начинаются и оканчиваются на одну букву


# 2. Содержат повторяющуюся пару букв


# 3. Содержат одну букву, повторенную по крайней мере трижды


#---------------------------------------------------------------------#

# Обнаружение соответствий
x <- c("apple", "banana", "pear")
str_detect(x, "e")

# How many common words start with t?
sum(str_detect(words, "^t"))
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))


# Выбор в соответствии с регулярным выражением
words[str_detect(words, "x$")]
str_subset(words, "x$")

df <- tibble(
  word = words, 
  i = seq_along(word)
)
df |>  filter(str_detect(word, "x$"))

# Подсчет числа соответствий
x <- c("apple", "banana", "pear")
str_count(x, "a")

# On average, how many vowels per word?
mean(str_count(words, "[aeiou]"))

df |>
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

#--- Самостоятельно --------------------------------------------------#
# В каком слове содержится наибольшее число гласных?

# В каком слове наибольшая доля гласных?

#---------------------------------------------------------------------#

# Извлечение соответствий
length(sentences)
head(sentences)

colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|")
colour_match

has_colour <- str_subset(sentences, colour_match)
matches <- str_extract(has_colour, colour_match)
head(matches)

table(matches) |> tibble() |> ggplot()

#--- Самостоятельно --------------------------------------------------#
# Из гарвардского набора предложений выберите
# 1. Первое слово из каждого предложения


# 2. Все слова, заканчивающиеся на "ing"


#---------------------------------------------------------------------#

# Замена соответствий
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")

sentences |>
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") |> 
  head(5)

# Разделение на компоненты
sentences |>
  head(5) |>
  str_split(" ")


