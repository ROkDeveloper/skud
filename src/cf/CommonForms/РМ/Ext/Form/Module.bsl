﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
    
    Если РольДоступна("ПолныеПрава") Тогда
        Элементы.Аднин.Видимость = Истина;
        Элементы.ОчередьСообщений.Видимость = Истина;
    Иначе
        Элементы.Аднин.Видимость = Ложь;
        Элементы.ОчередьСообщений.Видимость = Ложь;
    КонецЕсли;
    
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)  
    
    
КонецПроцедуры
 
 
&НаКлиенте
Процедура РегламентныеЗадания(Команда)
    ОткрытьФорму("Обработка.РегламентныеИФоновыеЗадания.Форма",);
КонецПроцедуры

&НаКлиенте
Процедура Пользователи(Команда)
    ОткрытьФорму("Справочник.Пользователи.Форма.ФормаСписка");
КонецПроцедуры

&НаКлиенте
Процедура ГруппыПользователей(Команда)
    ОткрытьФорму("Справочник.ГруппыПользователей.Форма.ФормаСписка",);
КонецПроцедуры

&НаКлиенте
Процедура ПрофилиГруппДоступа(Команда)
    ОткрытьФорму("Справочник.ПрофилиГруппДоступа.Форма.ФормаСписка",);
КонецПроцедуры

&НаКлиенте
Процедура АнализПравДоступа(Команда)
    ОткрытьФорму("Отчет.АнализПравДоступа.Форма");
КонецПроцедуры

&НаКлиенте
Процедура СведенияОПользователях(Команда)
    ОткрытьФорму("Отчет.СведенияОПользователях.Форма");
КонецПроцедуры

&НаКлиенте
Процедура ЖурналСобытийОтчет(Команда)
    ОткрытьФорму("Отчет.ОтчетЖурналСобытий.Форма");
КонецПроцедуры

&НаКлиенте
Процедура СписокНарушителей(Команда)
    ОткрытьФорму("Документ.ДокументСписокНарушителей.ФормаСписка",);
КонецПроцедуры

&НаКлиенте
Процедура ОбменCRabbit(Команда)
	ОткрытьФорму("Обработка.ПростойПримерРаботыСКомпонентойPinkRabbitMQ.Форма.Форма",);
КонецПроцедуры

&НаКлиенте
Процедура ПодключениеRabbit(Команда)
	ОткрытьФорму("Справочник.Подключение.Форма.ФормаСписка",);
КонецПроцедуры



