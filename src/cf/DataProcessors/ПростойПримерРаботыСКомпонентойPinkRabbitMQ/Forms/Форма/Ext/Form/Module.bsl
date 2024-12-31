﻿

&НаКлиенте
Перем Клиент, АдресВоВременномХранилище;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)        
	
	СтрПодключение = Справочники.Подключение.SERVER;
	
	Адрес             = СтрПодключение.Адрес;
	Порт              = СтрПодключение.Порт;
	Логин             = СтрПодключение.Логин;
	Пароль            = СтрПодключение.Пароль;
	ВиртуальныйХост   = СтрПодключение.ВиртуальныйХост;
	ТочкаОбмена       = СтрПодключение.ТочкаОбмена;
	ИмяОчереди        = СтрПодключение.ИмяОчереди; 
	КлючМаршрутизации = СтрПодключение.КлючМаршрутизации;   
	
	ТекстСообщения = ExchangeServer.СформироватьНаСервереТекст();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
		
КонецПроцедуры 

#КонецОбласти

#Область ОбработчикиКомандФормы     

&НаКлиенте
Процедура ПроверитьПодключение(Команда)
	
	Структура = Новый Структура;
	Структура.Вставить("Адрес", Адрес);
	Структура.Вставить("Порт", Порт);
	Структура.Вставить("Логин", Логин);
	Структура.Вставить("Пароль", Пароль);
	Структура.Вставить("ВиртуальныйХост", ВиртуальныйХост);
	Структура.Вставить("ТочкаОбмена", ТочкаОбмена);
	Структура.Вставить("ИмяОчереди", ИмяОчереди);
	
	КлиентКомпоненты = rabbitClientServer.ПолучитьКомпонентуСервер();
	rabbitClientServer.ПроверитьПодключениеКлиентСервер(КлиентКомпоненты,Структура);
	
КонецПроцедуры

&НаКлиенте
Процедура СозданиеТочкиИОчереди(Команда)
	
	Структура = Новый Структура;
	Структура.Вставить("Адрес", Адрес);
	Структура.Вставить("Порт", Порт);
	Структура.Вставить("Логин", Логин);
	Структура.Вставить("Пароль", Пароль);
	Структура.Вставить("ВиртуальныйХост", ВиртуальныйХост);
	Структура.Вставить("ТочкаОбмена", ТочкаОбмена);
	Структура.Вставить("ИмяОчереди", ИмяОчереди);
	
	rabbitClientServer.СозданиеТочкиИОчередиСервер(Структура);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьСообщение(Команда)
	
	ОтправитьСообщениеОбщее();
	
КонецПроцедуры     

&НаКлиенте
Процедура ПрочитатьСообщение(Команда)
	
	Структура = Новый Структура;
	Структура.Вставить("Адрес", Адрес);
	Структура.Вставить("Порт", Порт);
	Структура.Вставить("Логин", Логин);
	Структура.Вставить("Пароль", Пароль);
	Структура.Вставить("ВиртуальныйХост", ВиртуальныйХост);
	Структура.Вставить("ТочкаОбмена", ТочкаОбмена);
	Структура.Вставить("ИмяОчереди", ИмяОчереди);
	
	КлиентКомпоненты = rabbitClientServer.ПолучитьКомпонентуСервер();
	ОтветноеСообщение = rabbitClientServer.ПрочитатьСообщениеКлиентСервер(КлиентКомпоненты,Структура);
	
	ОбработатьСообщениеНаСервере();
	
КонецПроцедуры   

Процедура ОбработатьСообщениеНаСервере()

	РегистрыСведений.ЖурналСобытий.ЗаписатьСобытиеВЖурнал(ОтветноеСообщение);

КонецПроцедуры

&НаКлиенте
Процедура ОтправитьСообщениеОбщее()
	
	ТекстСообщения = ТекстСообщения();
	
	Структура = Новый Структура;
	Структура.Вставить("Адрес", Адрес);
	Структура.Вставить("Порт", Порт);
	Структура.Вставить("Логин", Логин);
	Структура.Вставить("Пароль", Пароль);
	Структура.Вставить("ВиртуальныйХост", ВиртуальныйХост);
	Структура.Вставить("ТочкаОбмена", ТочкаОбмена);
	Структура.Вставить("ИмяОчереди", ИмяОчереди); 
	Структура.Вставить("ТекстСообщения", ТекстСообщения);
	Структура.Вставить("КлючМаршрутизации", КлючМаршрутизации);
	
	КлиентКомпоненты = rabbitClientServer.ПолучитьКомпонентуСервер();
	rabbitClientServer.ОтправитьСообщениеКлиентСервер(КлиентКомпоненты,Структура);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ТекстСообщения()
	
	Возврат ExchangeServer.СформироватьНаСервереТекст();
	
КонецФункции // ()


#КонецОбласти 



















