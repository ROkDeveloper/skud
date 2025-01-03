﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Проверяет, содержит ли строка только символы кириллического алфавита.
//
// Параметры:
//  СтрокаПроверки - Строка - проверяемая строка.
//  УчитыватьРазделителиСлов - Булево - учитывать ли разделители слов или они являются исключением.
//  ДопустимыеСимволы - Строка - дополнительные разрешенные символы, кроме кириллицы.
//
// Возвращаемое значение:
//  Булево - Истина, если строка содержит только кириллические (или допустимые) символы или пустая;
//           Ложь, если строка содержит иные символы.
//
Функция ТолькоКириллицаВСтроке(Знач СтрокаПроверки, Знач УчитыватьРазделителиСлов = Истина, ДопустимыеСимволы = "") Экспорт
	
	Если ТипЗнч(СтрокаПроверки) <> Тип("Строка") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(СтрокаПроверки) Тогда
		Возврат Истина;
	КонецЕсли;
	
	// АПК:163-выкл В данных буква допустима.
	КодыДопустимыхСимволов = Новый Массив;
	КодыДопустимыхСимволов.Добавить(1105); // "ё"
	КодыДопустимыхСимволов.Добавить(1025); // "Ё"
	// АПК:163-вкл
	
	Для Индекс = 1 По СтрДлина(ДопустимыеСимволы) Цикл
		КодыДопустимыхСимволов.Добавить(КодСимвола(Сред(ДопустимыеСимволы, Индекс, 1)));
	КонецЦикла;
	
	Для Индекс = 1 По СтрДлина(СтрокаПроверки) Цикл
		КодСимвола = КодСимвола(Сред(СтрокаПроверки, Индекс, 1));
		Если ((КодСимвола < 1040) Или (КодСимвола > 1103)) 
			И (КодыДопустимыхСимволов.Найти(КодСимвола) = Неопределено) 
			И Не (Не УчитыватьРазделителиСлов И СтроковыеФункцииКлиентСервер.ЭтоРазделительСлов(КодСимвола)) Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти