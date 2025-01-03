﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Функция НастройкиПечати() Экспорт
	
	Настройки = УправлениеПечатью.НастройкиПечати();
	
	ОбъектыПечати = Новый Соответствие;
	Для Каждого ОбъектПечати Из Настройки.ОбъектыПечати Цикл
		ОбъектыПечати.Вставить(ОбъектПечати, Истина);
	КонецЦикла;
	
	Настройки.ОбъектыПечати = Новый ФиксированноеСоответствие(ОбъектыПечати);
	
	Возврат Настройки;
	
КонецФункции

Функция ОбъектыСКомандамиПечати() Экспорт
	
	ОбъектыСКомандамиПечати = Новый Массив;
	ИнтеграцияПодсистемБСП.ПриОпределенииОбъектовСКомандамиПечати(ОбъектыСКомандамиПечати); // АПК:222 Вызов устаревшей процедуры для обратной совместимости.
	УправлениеПечатьюПереопределяемый.ПриОпределенииОбъектовСКомандамиПечати(ОбъектыСКомандамиПечати); // АПК:222 Вызов устаревшей процедуры для обратной совместимости.
	
	Результат = Новый Соответствие;
	Для Каждого ОбъектПечати Из ОбъектыСКомандамиПечати Цикл
		Результат.Вставить(ОбъектПечати, Истина);
	КонецЦикла;
		
	Возврат Новый ФиксированноеСоответствие(Результат);
	
КонецФункции

#КонецОбласти
