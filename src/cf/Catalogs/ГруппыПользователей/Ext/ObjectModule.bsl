﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

// Значения объекта до записи для использования в обработчике события ПриЗаписи.
Перем ЭтоНовый, СтарыйРодитель, СтарыйСостав, ЭтоПолноправныйПользователь;

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ПроверенныеРеквизитыОбъекта = Новый Массив;
	Ошибки = Неопределено;
	
	// Проверка использования родителя.
	Если Родитель = Пользователи.ГруппаВсеПользователи() Тогда
		ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки,
			"Объект.Родитель",
			НСтр("ru = 'Группа ""Все пользователи"" не может быть родителем.'"),
			"");
	КонецЕсли;
	
	// Проверка незаполненных и повторяющихся пользователей.
	ПроверенныеРеквизитыОбъекта.Добавить("Состав.Пользователь");
	
	Для каждого ТекущаяСтрока Из Состав Цикл;
		НомерСтроки = Состав.Индекс(ТекущаяСтрока);
		
		// Проверка заполнения значения.
		Если НЕ ЗначениеЗаполнено(ТекущаяСтрока.Пользователь) Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки,
				"Объект.Состав[%1].Пользователь",
				НСтр("ru = 'Пользователь не выбран.'"),
				"Объект.Состав",
				НомерСтроки,
				НСтр("ru = 'Пользователь в строке %1 не выбран.'"));
			Продолжить;
		КонецЕсли;
		
		// Проверка наличия повторяющихся значений.
		НайденныеЗначения = Состав.НайтиСтроки(Новый Структура("Пользователь", ТекущаяСтрока.Пользователь));
		Если НайденныеЗначения.Количество() > 1 Тогда
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки,
				"Объект.Состав[%1].Пользователь",
				НСтр("ru = 'Пользователь повторяется.'"),
				"Объект.Состав",
				НомерСтроки,
				НСтр("ru = 'Пользователь в строке %1 повторяется.'"));
		КонецЕсли;
	КонецЦикла;
	
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, ПроверенныеРеквизитыОбъекта);
	
КонецПроцедуры

// Блокирует недопустимые действия с предопределенной группой "Все пользователи".
Процедура ПередЗаписью(Отказ)
	
	// АПК:75-выкл проверка ОбменДанными.Загрузка должна быть после блокировки регистров.
	Если ОбщегоНазначения.ИнформационнаяБазаФайловая() Тогда
		ПользователиСлужебный.ЗаблокироватьРегистрыПередЗаписьюВФайловойИБ(Истина);
	КонецЕсли;
	// АПК:75-вкл
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ЭтоНовый = ЭтоНовый();
	ЭтоПолноправныйПользователь = Пользователи.ЭтоПолноправныйПользователь();
	
	Если Не ЭтоНовый Тогда
		СтарыеЗначения = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка,
			"Родитель" + ?(ЭтоПолноправныйПользователь, "", ", Состав"));
		СтарыйРодитель = СтарыеЗначения.Родитель;
		СтарыйСостав   = ?(ЭтоПолноправныйПользователь,
			Неопределено, СтарыеЗначения.Состав.Выгрузить());
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ГруппаВсеПользователи = Пользователи.ГруппаВсеПользователи();
	
	Если Ссылка = ГруппаВсеПользователи Тогда
		Если Не Родитель.Пустая() Тогда
			ТекстОшибки = НСтр("ru = 'Группа ""Все пользователи"" может быть только в корне.'");
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
		Если Состав.Количество() > 0 Тогда
			ТекстОшибки = НСтр("ru = 'Добавление участников в группу ""Все пользователи"" запрещено.'");
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
	Иначе
		Если Родитель = ГруппаВсеПользователи Тогда
			ТекстОшибки = НСтр("ru = 'Группа ""Все пользователи"" не может быть родителем.'");
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
	КонецЕсли;
	
	Если Не ЭтоПолноправныйПользователь И Ссылка <> ГруппаВсеПользователи Тогда
		ИзменениеСостава = ПользователиСлужебный.РазличияЗначенийКолонки("Пользователь",
			Состав.Выгрузить(), СтарыйСостав);
		ПроверитьПравоИзмененияСостава(ИзменениеСостава);
	КонецЕсли;
	
	ИзмененияСоставов = ПользователиСлужебный.НовыеИзмененияСоставовГрупп();
	
	Если Ссылка = ГруппаВсеПользователи Тогда
		ПользователиСлужебный.ОбновитьСоставГруппыВсеПользователи(
			Справочники.Пользователи.ПустаяСсылка(), ИзмененияСоставов);
	Иначе
		Если СтарыйРодитель <> Родитель Тогда
			ПользователиСлужебный.ОбновитьИерархиюГрупп(Ссылка, ИзмененияСоставов, Ложь);
			
			Если ЗначениеЗаполнено(СтарыйРодитель) Тогда
				ПользователиСлужебный.ОбновитьСоставыИерархическихГруппПользователей(СтарыйРодитель,
					ИзмененияСоставов);
			КонецЕсли;
		КонецЕсли;
		
		ПользователиСлужебный.ОбновитьСоставыИерархическихГруппПользователей(Ссылка,
			ИзмененияСоставов);
	КонецЕсли;
	
	ПользователиСлужебный.ПослеОбновленияСоставовГруппПользователей(ИзмененияСоставов);
	
	ИнтеграцияПодсистемБСП.ПослеДобавленияИзмененияПользователяИлиГруппы(Ссылка, ЭтоНовый);
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПользователиСлужебный.ОбновитьСоставыГруппПередУдалениемПользователяИлиГруппы(Ссылка);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьПравоИзмененияСостава(ИзменениеСостава)
	
	Если Не ЗначениеЗаполнено(ИзменениеСостава) Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Пользователи", ИзменениеСостава);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Пользователи.Наименование КАК Наименование
	|ИЗ
	|	Справочник.Пользователи КАК Пользователи
	|ГДЕ
	|	Пользователи.Ссылка В(&Пользователи)
	|	И НЕ Пользователи.Подготовлен";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	СоставПользователей = РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Наименование");
	
	ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Недостаточно прав доступа для изменения:
		           |%1
		           |
		           |В состав участников групп пользователей можно включать и исключать
		           |только новых пользователей, которые еще не одобрены администратором
		           |(то есть администратор еще не разрешил вход в приложение).'"),
		СтрСоединить(СоставПользователей, Символы.ПС));
	ВызватьИсключение(ТекстОшибки, КатегорияОшибки.НарушениеПравДоступа);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли