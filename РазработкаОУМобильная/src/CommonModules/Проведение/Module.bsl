
#Область ПрограммныйИнтерфейс

// Процедура инициализирует общие структуры, используемые при проведении документов.
// Вызывается из модуля документов при проведении.
//
Процедура ИнициализироватьДополнительныеСвойстваДляПроведения(ДокументСсылка, ДополнительныеСвойства, РежимПроведения = Неопределено) Экспорт

	// В структуре "ДополнительныеСвойства" создаются свойства с ключами "ТаблицыДляДвижений", "ДляПроведения".

	// "ТаблицыДляДвижений" - структура, которая будет содержать таблицы значений с данными для выполнения движений.
	ДополнительныеСвойства.Вставить("ТаблицыДляДвижений", Новый Структура);

	// "ДляПроведения" - структура, содержащая свойства и реквизиты документа, необходимые для проведения.
	ДополнительныеСвойства.Вставить("ДляПроведения", Новый Структура);
	
	// Структура, содержащая ключ с именем "МенеджерВременныхТаблиц", в значении которого хранится менеджер временных
	// таблиц.
	// Содержит для каждой временной таблицы ключ (имя временной таблицы) и значение (признак наличия записей во временной
	// таблице).
	ДополнительныеСвойства.ДляПроведения.Вставить("СтруктураВременныеТаблицы", Новый Структура("МенеджерВременныхТаблиц", Новый МенеджерВременныхТаблиц));
	ДополнительныеСвойства.ДляПроведения.Вставить("РежимПроведения",           РежимПроведения);
	ДополнительныеСвойства.ДляПроведения.Вставить("МетаданныеДокумента",       ДокументСсылка.Метаданные());
	ДополнительныеСвойства.ДляПроведения.Вставить("Ссылка",                    ДокументСсылка);

КонецПроцедуры

// Процедура выполняет подготовку наборов записей документа к записи движений.
// 1. Очищает наборы записей от "старых записей" (ситуация возможна только в толстом клиенте).
// 2. Взводит флаг записи у наборов, по которым документ имеет движения.
// Вызывается из модуля документов при проведении.
//
Процедура ПодготовитьНаборыЗаписейКРегистрацииДвижений(Объект) Экспорт
	
	Для Каждого НаборЗаписей Из Объект.Движения Цикл
		
		Если НаборЗаписей.Количество() > 0 Тогда
			НаборЗаписей.Очистить();
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Функция формирует массив имен регистров, по которым документ имеет движения.
// Вызывается при подготовке записей к регистрации движений.
//
Функция ПолучитьМассивИспользуемыхРегистров(Регистратор, Движения, МассивИсключаемыхРегистров = Неопределено) Экспорт

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Регистратор);

	Результат = Новый Массив;
	МаксимумТаблицВЗапросе = 256;

	СчетчикТаблиц   = 0;
	СчетчикДвижений = 0;

	ВсегоДвижений = Движения.Количество();
	ТекстЗапроса  = "";
	Для Каждого Движение Из Движения Цикл

		СчетчикДвижений = СчетчикДвижений + 1;

		ПропуститьРегистр = МассивИсключаемыхРегистров <> Неопределено
							И МассивИсключаемыхРегистров.Найти(Движение.Имя) <> Неопределено;

		Если Не ПропуститьРегистр Тогда

			Если СчетчикТаблиц > 0 Тогда

				ТекстЗапроса = ТекстЗапроса 
				+ "
				|ОБЪЕДИНИТЬ ВСЕ
				|";

			КонецЕсли;

			СчетчикТаблиц = СчетчикТаблиц + 1;

			ТекстЗапроса = ТекстЗапроса 
			+ "
			|ВЫБРАТЬ ПЕРВЫЕ 1
			|""" + Движение.Имя + """ КАК ИмяРегистра
			|
			|ИЗ " + Движение.ПолноеИмя() + "
			|
			|ГДЕ Регистратор = &Регистратор
			|";

		КонецЕсли;

		Если СчетчикТаблиц = МаксимумТаблицВЗапросе Или СчетчикДвижений = ВсегоДвижений Тогда

			Запрос.Текст  = ТекстЗапроса;
			ТекстЗапроса  = "";
			СчетчикТаблиц = 0;

			Если Результат.Количество() = 0 Тогда

				Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ИмяРегистра");

			Иначе

				Выборка = Запрос.Выполнить().Выбрать();
				Пока Выборка.Следующий() Цикл
					Результат.Добавить(Выборка.ИмяРегистра);
				КонецЦикла;

			КонецЕсли;
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;

КонецФункции

// Процедура записывает движения документа. Дополнительно происходит копирование параметров
// в модули наборов записей для выполнения регистрации изменений в движениях.
// Процедура вызывается из модуля документов при проведении.
//
Процедура ЗаписатьНаборыЗаписей(Знач Объект) Экспорт
	Перем РегистрыДляКонтроля;

	
	// Регистры, для которых будут рассчитаны таблицы изменений движений.
	Если Объект.ДополнительныеСвойства.ДляПроведения.Свойство("РегистрыДляКонтроля", РегистрыДляКонтроля) Тогда
		Для Каждого НаборЗаписей Из РегистрыДляКонтроля Цикл
			Если НаборЗаписей.Записывать Тогда

				// Установка флага регистрации изменений в наборе записей.
				НаборЗаписей.ДополнительныеСвойства.Вставить("РассчитыватьИзменения", Истина);
				
				// Структура для передачи данных в модули наборов записей.
				НаборЗаписей.ДополнительныеСвойства.Вставить("ДляПроведения", 
						Новый Структура("СтруктураВременныеТаблицы", Объект.ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы));

			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	
	Объект.Движения.Записать();

КонецПроцедуры

// Процедура выполняет контроль результатов проведения.
// Процедура вызывается из модуля документов при проведении.
//
Процедура ВыполнитьКонтрольРезультатовПроведения(Объект, Отказ) Экспорт

	Если Объект.ДополнительныеСвойства.ДляПроведения.РегистрыДляКонтроля.Количество() = 0 Тогда
		
		Возврат;
		
	КонецЕсли;

	ДанныеТаблиц    = Объект.ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	ПакетЗапросов   = Новый Запрос;
	МассивКонтролей = Новый Массив;
	ТекстЗапроса    = "";
	
	// Контроль отрицательных остатков наличных
	Если ЕстьИзмененияВТаблице(ДанныеТаблиц,"ДвиженияНаличныеИзменение") Тогда
		
		МассивКонтролей.Добавить(ВРег("ДенежныеСредства"));
		ТекстЗапроса = ТекстЗапроса + 
		"ВЫБРАТЬ
		|	НаличныеОстатки.СуммаОстаток КАК Сумма
		|ИЗ
		|	РегистрНакопления.ДенежныеСредства.Остатки(, ТипОплаты = ЗНАЧЕНИЕ(Перечисление.ТипыОплаты.Наличные)) КАК НаличныеОстатки
		|ГДЕ
		|	НаличныеОстатки.СуммаОстаток < 0";
		
	КонецЕсли;
		
		
	Если МассивКонтролей.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПакетЗапросов.Текст = ТекстЗапроса;
	ПакетЗапросов.МенеджерВременныхТаблиц = ДанныеТаблиц.МенеджерВременныхТаблиц;
	МассивРезультатов = ПакетЗапросов.ВыполнитьПакет();
	Итератор = -1;
	Для Каждого Результат Из МассивРезультатов Цикл
	
		Итератор = Итератор + 1;
		Если Результат.Пустой() Тогда
			
			Продолжить;
			
		КонецЕсли;
	
		ИмяКонтроля = МассивКонтролей[Итератор];
	
		Если ИмяКонтроля = ВРег("Наличные") Тогда
	
			СообщитьОбОшибкахПроведенияПоРегиструНаличные(Объект, Отказ, Результат);
			
		Иначе
	
			ВызватьИсключение НСтр("ru = 'Ошибка контроля проведения!'");
	
		КонецЕсли;
		
	КонецЦикла;
	
	Если Отказ Тогда
	
		ТекстСообщения = НСтр("ru = 'Проведение не выполнено'");
	
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	
	КонецЕсли;
	
КонецПроцедуры

// Процедура закрывает МВТ, используемый при формировании движений
//
Процедура ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства) Экспорт

	ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы.МенеджерВременныхТаблиц.Закрыть();

КонецПроцедуры

// Функция вызывается из модулей наборов записей для проверки необходимости
// контроля изменений движений в регистре.
//
Функция РассчитыватьИзменения(ДополнительныеСвойстваНабораЗаписей) Экспорт
	Перем РассчитыватьИзменения;

	Возврат ДополнительныеСвойстваНабораЗаписей.Свойство("РассчитыватьИзменения", РассчитыватьИзменения)
		И РассчитыватьИзменения;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедуры выдачи сообщений об ошибках проведения.
//
Процедура СообщитьОбОшибкахПроведенияПоРегиструНаличные(Объект, Отказ, РезультатЗапроса)
	
	ТекстСообщения = НСтр("ru = 'Недостаточно наличных'");
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	
КонецПроцедуры

// Функция проверяет наличие изменений в таблице регистра.
//
Функция ЕстьИзмененияВТаблице(СтруктураДанных, Ключ)
	Перем ЕстьИзменения;

	Возврат СтруктураДанных.Свойство(Ключ, ЕстьИзменения) И ЕстьИзменения;

КонецФункции

#КонецОбласти