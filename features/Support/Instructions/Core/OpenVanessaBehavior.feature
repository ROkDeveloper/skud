# language: ru
# encoding: utf-8
#parent uf:
@UF9_Вспомогательные_фичи
#parent ua:
@UA47_Макеты_запуска_VA

@IgnoreOnCIMainBuild

Функционал: Открытие обработки vanessa-behavior
	Как Разработчик
	Хочу Иметь возможность открыть обработку vanessa-behavior
	Чтобы Вести разработку по bdd

Сценарий: Открытие 1C. Открытие обработки vanessa-behavior
	Дано Я запускаю 1С в режиме клиента тестирвания

Сценарий: Открытие обработки
	Дано Я в запущеном экземпляре 1С в режиме клиента тесторования открываю обработку vanessa-behavior

Сценарий: Закрытие 1С. Открытие обработки vanessa-behavior
	Дано Я закрываю запущенный в режиме клиент тестирования экземпляр 1С