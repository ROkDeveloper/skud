﻿

#Область ПрограммныйИнтерфейс 

Процедура ExportData() Экспорт   
	
	ТекстСообщения = СформироватьНаСервереТекст();
	Если ТекстСообщения = "[]" Тогда
		Возврат;	
	КонецЕсли;
	СтрПодключение = Справочники.Подключение.НайтиПоКоду("000000001"); //просто для примера
	
	Структура = Новый Структура;
	Структура.Вставить("Адрес",             СтрПодключение.Адрес);
	Структура.Вставить("Порт",              СтрПодключение.Порт);
	Структура.Вставить("Логин",             СтрПодключение.Логин);
	Структура.Вставить("Пароль",            СтрПодключение.Пароль);
	Структура.Вставить("ВиртуальныйХост",   СтрПодключение.ВиртуальныйХост);
	Структура.Вставить("ТочкаОбмена",       СтрПодключение.ТочкаОбмена);
	Структура.Вставить("ИмяОчереди",        СтрПодключение.ИмяОчереди); 
	Структура.Вставить("ТекстСообщения",    ТекстСообщения);
	Структура.Вставить("КлючМаршрутизации", СтрПодключение.КлючМаршрутизации);
	
	КлиентКомпоненты = rabbitClientServer.ПолучитьКомпонентуСервер();
	rabbitClientServer.ОтправитьСообщениеКлиентСервер(КлиентКомпоненты,Структура);
	
КонецПроцедуры

Процедура ImportData() Экспорт
	
	СтрПодключение = Справочники.Подключение.НайтиПоКоду("000000001"); //просто для примера
	
	Структура = Новый Структура;
	Структура.Вставить("Адрес",             СтрПодключение.Адрес);
	Структура.Вставить("Порт",              СтрПодключение.Порт);
	Структура.Вставить("Логин",             СтрПодключение.Логин);
	Структура.Вставить("Пароль",            СтрПодключение.Пароль);
	Структура.Вставить("ВиртуальныйХост",   СтрПодключение.ВиртуальныйХост);
	Структура.Вставить("ТочкаОбмена",       СтрПодключение.ТочкаОбмена);
	Структура.Вставить("ИмяОчереди",        СтрПодключение.ИмяОчереди); 
	
	
	КлиентКомпоненты = rabbitClientServer.ПолучитьКомпонентуСервер();
	ОтветноеСообщение = rabbitClientServer.ПрочитатьСообщениеКлиентСервер(КлиентКомпоненты,Структура);   
	
КонецПроцедуры

Функция СформироватьНаСервере()Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЖурналСобытий.Период КАК time,
	               |	ЖурналСобытий.ОбъектДоступа КАК object,
	               |	ЖурналСобытий.ТочкаДоступа КАК point,
	               |	ЖурналСобытий.Направление КАК direction,
	               |	ЖурналСобытий.ГосНомера КАК number,
	               |	ЖурналСобытий.ОбъектДоступа.Должность КАК job,
	               |	ЖурналСобытий.ОбъектДоступа.Отдел КАК department,
	               |	ЖурналСобытий.ОбъектДоступа.ТабельныйНомер КАК objtabnum
	               |ИЗ
	               |	РегистрСведений.ЖурналСобытий КАК ЖурналСобытий";
	
	Массив = Новый Массив;
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл	
		
		Структура = Новый Структура;
		Структура.Вставить("time",       Строка(Выборка.time)); 
		Структура.Вставить("date",       Строка(ТекущаяДатаСеанса()));
		Структура.Вставить("object",     Строка(Выборка.object));
		Структура.Вставить("point",      Строка(Выборка.point)); 
		Структура.Вставить("direction",  Строка(Выборка.direction));
		Структура.Вставить("number",     Строка(Выборка.number));
		Структура.Вставить("job",        Строка(Выборка.job)); 
		Структура.Вставить("department", Строка(Выборка.department)); 
		Структура.Вставить("objtabnum",  Строка(Выборка.objtabnum)); 
		
		Массив.Добавить(Структура); 
		
	КонецЦикла;
	
	
	Возврат БОНД_Коннектор.ОбъектВJson(Массив); 
	
	КонецФункции 
	
	Функция СформироватьНаСервереТекст()Экспорт 
	

	Строка =   //31.12.2024 
	"[
	|{
	|""time"": ""01.01.0001 8:27:47"",
	|""date"": ""31.12.2024 8:33:57"",
	|""object"": ""Засульский Денис Викторович"",
	|""point"": ""МКЦ Турникет 3"",
	|""direction"": ""Вход"",
	|""number"": """",
	|""job"": ""Программист 1С"",
	|""department"": ""Отдел программирования ООО \""КИБЕРЛАБ\"""",
	|""objtabnum"": ""66565"", 
	|""objphonenumber"":""79002371457""
	|},
	|{
	|""time"": ""01.01.0001 17:00:00"",
	|""date"": ""31.12.2024 8:33:57"",
	|""object"": ""Засульский Денис Викторович"",
	|""point"": ""МКЦ Турникет 3"",
	|""direction"": ""Выход"",
	|""number"": """",
	|""job"": ""Программист 1С"",
	|""department"": ""Отдел программирования ООО \""КИБЕРЛАБ\"""",
	|""objtabnum"": ""66565"", 
	|""objphonenumber"":""79002371457""
	|},
	|{
	|""time"": ""01.01.0001 8:00:00"",
	|""date"": ""31.12.2024 8:33:57"",
	|""object"": ""Никитин Алексей  Александрович"",
	|""point"": ""МКЦ Турникет 3"",
	|""direction"": ""Вход"",
	|""number"": """",
	|""job"": ""Ведущий программист 1С"",
	|""department"": ""Отдел программирования ООО \""КИБЕРЛАБ\"""",
	|""objtabnum"": ""1212121"", 
	|""objphonenumber"":""79002371457""
	|},
	|{
	|""time"": ""01.01.0001 17:00:00"",
	|""date"": ""31.12.2024 8:33:57"",
	|""object"": ""Никитин Алексей  Александрович"",
	|""point"": ""МКЦ Турникет 3"",
	|""direction"": ""Выход"",
	|""number"": """",
	|""job"": ""Ведущий программист 1С"",
	|""department"": ""Отдел программирования ООО \""КИБЕРЛАБ\"""",
	|""objtabnum"": ""1212121"", 
	|""objphonenumber"":""79002371457""
	|},
	|{
	|""time"": ""01.01.0001 8:27:47"",
	|""date"": ""31.12.2024 8:33:57"",
	|""object"": ""Окдиров Ресул"",
	|""point"": ""МКЦ Турникет 3"",
	|""direction"": ""Вход"",
	|""number"": """",
	|""job"": ""Программист 1С"",
	|""department"": ""Отдел программирования ООО \""КИБЕРЛАБ\"""",
	|""objtabnum"": ""97876"", 
	|""objphonenumber"":""79002371457""
	|},
	|{
	|""time"": ""01.01.0001 17:00:00"",
	|""date"": ""31.12.2024 8:33:57"",
	|""object"": ""Окдиров Ресул"",
	|""point"": ""МКЦ Турникет 3"",
	|""direction"": ""Выход"",
	|""number"": """",
	|""job"": ""Программист 1С"",
	|""department"": ""Отдел программирования ООО \""КИБЕРЛАБ\"""",
	|""objtabnum"": ""97876"", 
	|""objphonenumber"":""79002371457""
	|}]"; 
	
	Возврат Строка; 

КонецФункции  

#КонецОбласти

