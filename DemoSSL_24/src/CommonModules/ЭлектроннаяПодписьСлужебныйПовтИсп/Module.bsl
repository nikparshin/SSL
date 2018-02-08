#Область СлужебныеПроцедурыИФункции

// Только для внутреннего использования.
Функция ОбщиеНастройки() Экспорт
	
	ОбщиеНастройки = Новый Структура;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОбщиеНастройки.Вставить("ИспользоватьЭлектронныеПодписи",
		Константы.ИспользоватьЭлектронныеПодписи.Получить());
	
	ОбщиеНастройки.Вставить("ИспользоватьШифрование",
		Константы.ИспользоватьШифрование.Получить());
	
	Если ОбщегоНазначения.РазделениеВключено()
	 Или ОбщегоНазначения.ИнформационнаяБазаФайловая()
	   И Не ОбщегоНазначенияКлиентСервер.КлиентПодключенЧерезВебСервер() Тогда
		
		ОбщиеНастройки.Вставить("ПроверятьЭлектронныеПодписиНаСервере", Ложь);
		ОбщиеНастройки.Вставить("СоздаватьЭлектронныеПодписиНаСервере", Ложь);
	Иначе
		ОбщиеНастройки.Вставить("ПроверятьЭлектронныеПодписиНаСервере",
			Константы.ПроверятьЭлектронныеПодписиНаСервере.Получить());
		
		ОбщиеНастройки.Вставить("СоздаватьЭлектронныеПодписиНаСервере",
			Константы.СоздаватьЭлектронныеПодписиНаСервере.Получить());
	КонецЕсли;
	
	// Использование подсистем.
	// 1. Подсистема Контактная информация  - российский адрес.
	// 2. Подсистема Адресный классификатор - код региона по наименованию.
	// 3. Подсистема Печать - стандартная печатная форма для заявления на выпуск сертификата.
	// 4. Подсистема Работа с контрагентами - проверка ИНН, КПП, ОГРН, лицевого счета по БИК, СНИЛС.
	// 5. Подсистема Интернет поддержка пользователей - подключение сервисам 1С.
	
	ОбщиеНастройки.Вставить("ЗаявлениеНаВыпускСертификатаДоступно",
		  ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.АдресныйКлассификатор")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Печать")
		И ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей")
		И Метаданные.Обработки.Найти("ЗаявлениеНаВыпускНовогоКвалифицированногоСертификата") <> Неопределено);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Программы.Ссылка,
	|	Программы.Наименование КАК Наименование,
	|	Программы.ИмяПрограммы,
	|	Программы.ТипПрограммы,
	|	Программы.АлгоритмПодписи,
	|	Программы.АлгоритмХеширования,
	|	Программы.АлгоритмШифрования
	|ИЗ
	|	Справочник.ПрограммыЭлектроннойПодписиИШифрования КАК Программы
	|ГДЕ
	|	НЕ Программы.ПометкаУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	Наименование";
	
	Выборка = Запрос.Выполнить().Выбрать();
	ОписанияПрограмм = Новый Массив;
	ПоставляемыеНастройки = Справочники.ПрограммыЭлектроннойПодписиИШифрования.ПоставляемыеНастройкиПрограмм();
	
	Пока Выборка.Следующий() Цикл
		Отбор = Новый Структура("ИмяПрограммы, ТипПрограммы", Выборка.ИмяПрограммы, Выборка.ТипПрограммы);
		Строки = ПоставляемыеНастройки.НайтиСтроки(Отбор);
		Идентификатор = ?(Строки.Количество() = 0, "", Строки[0].Идентификатор);
		
		Описание = Новый Структура;
		Описание.Вставить("Ссылка",              Выборка.Ссылка);
		Описание.Вставить("Наименование",        Выборка.Наименование);
		Описание.Вставить("ИмяПрограммы",        Выборка.ИмяПрограммы);
		Описание.Вставить("ТипПрограммы",        Выборка.ТипПрограммы);
		Описание.Вставить("АлгоритмПодписи",     Выборка.АлгоритмПодписи);
		Описание.Вставить("АлгоритмХеширования", Выборка.АлгоритмХеширования);
		Описание.Вставить("АлгоритмШифрования",  Выборка.АлгоритмШифрования);
		Описание.Вставить("Идентификатор",       Идентификатор);
		ОписанияПрограмм.Добавить(Новый ФиксированнаяСтруктура(Описание));
	КонецЦикла;
	
	ОбщиеНастройки.Вставить("ОписанияПрограмм", Новый ФиксированныйМассив(ОписанияПрограмм));
	
	Возврат Новый ФиксированнаяСтруктура(ОбщиеНастройки);
	
КонецФункции

// Возвращает соответствие типов программ электронной подписи по именам.
//
// Возвращаемое значение:
//  Соответствие со свойствами:
//     * Ключ     - Строка - Уникальное имя программы, присвоенное ее разработчиком.
//     * Значение - Число  - Число, которое описывает тип программы и дополняет имя программы.
//
Функция ТипыПрограммЭлектроннойПодписи() Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат Новый ФиксированноеСоответствие(Новый Соответствие);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ПрограммыЭлектроннойПодписиИШифрования.ИмяПрограммы,
	|	ПрограммыЭлектроннойПодписиИШифрования.ТипПрограммы
	|ИЗ
	|	Справочник.ПрограммыЭлектроннойПодписиИШифрования КАК ПрограммыЭлектроннойПодписиИШифрования");
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	ТипыПрограммЭлектроннойПодписи = Новый Соответствие;
	Пока Выборка.Следующий() Цикл
		ТипыПрограммЭлектроннойПодписи.Вставить(Выборка.ИмяПрограммы, Выборка.ТипПрограммы);
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(ТипыПрограммЭлектроннойПодписи);
	
КонецФункции

Функция ТипыВладельцев(ТолькоСсылки = Ложь) Экспорт
	
	Результат = Новый Соответствие;
	Типы = Метаданные.ОпределяемыеТипы.ПодписанныйОбъект.Тип.Типы();
	
	Для Каждого Тип Из Типы Цикл
		Если Тип = Тип("Неопределено")
		 Или Тип = Тип("Строка")
		 Или Тип = Тип("СправочникСсылка." + "ВерсииФайлов") Тогда
			Продолжить;
		КонецЕсли;
		Результат.Вставить(Тип, Истина);
		Если Не ТолькоСсылки Тогда
			ИмяТипаОбъекта = СтрЗаменить(Метаданные.НайтиПоТипу(Тип).ПолноеИмя(), ".", "Объект.");
			Результат.Вставить(Тип(ИмяТипаОбъекта), Истина);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(Результат);
	
КонецФункции

#КонецОбласти
