/*

База данных состоит из трех таблиц: товары по заводам и движения.
Код_товара, Номер_документа, Номер_строки_документа


Товары

Код_товара
Вес_нетто
Категория
Описание



Движения

Код_товара
Приход_Расход 
Количество_ЕИ
Сумма_Руб
Дата
Код_завод
Номер_документа
Номер_строки_документа



Заводы

Код_завода
Дата_открытия
Дата_закрытия




Написать ANSI SQL, применение функций даты времени опционально:

Вариант 2. Вес нетто ненулевых остатков товаров в разрезе по заводам, открытым с 1 января 2015 года, и не закрытым по состоянию на 1 мая 2015 года

Остаток равен сумме приходов за вычетом суммы расходов

*/





SELECT Заводы.Код_Завода, sum(Общий_Вес)
FROM(
SELECT Товары.Код_товара, Вес_Нетто, Код_Завода, (SUM(case when Приход_Расход= 1 then Количество_ЕИ else 0 end) - SUM(case when Приход_Расход= 0 then Количество_ЕИ else 0 end))*Вес_Нетто as 'Общий_Вес'
FROM Движения join Товары on Движения.Код_товара = Товары.Код_товара
GROUP BY Товары.Код_товара, Движения.Код_завода
HAVING Общий_Вес > 0) as Вложенный_Запрос join Заводы on Вложенный_Запрос.Код_Завода = Заводы.Код_Завода
Group by Заводы.Код_Завода