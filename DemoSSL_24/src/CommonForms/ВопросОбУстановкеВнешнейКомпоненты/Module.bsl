
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Не ПустаяСтрока(Параметры.ТекстПояснения) Тогда
		Элементы.ДекорацияПояснение.Заголовок = Параметры.ТекстПояснения
			+ Символы.ПС
			+ НСтр("ru = 'Установить?'");

	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти