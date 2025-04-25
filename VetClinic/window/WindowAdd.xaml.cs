//using System;
//using System.Linq;
//using System.Windows;
//using VetClinic.db;

//namespace VetClinic.window
//{
//    public partial class WindowAdd : Window
//    {
//        public event Action DataSaved; // Событие для оповещения об успешном сохранении

//        public WindowAdd()
//        {
//            InitializeComponent();
//            LoadData();
//        }

//        private void LoadData()
//        {
//            try
//            {
//                cbAnimalType.ItemsSource = Connection.vetclinicEntities.TypeAni.ToList();
//                cbAnimalGender.ItemsSource = Connection.vetclinicEntities.Gender.ToList();
//                cbDoctor.ItemsSource = Connection.vetclinicEntities.Doctor
//                    .Select(d => new { d.ID, FullName = $"{d.LastName} {d.Name} {d.Patronymic}", d.IdTypeDoc })
//                    .ToList();
//                dpDate.SelectedDate = DateTime.Today;
//            }
//            catch (Exception ex)
//            {
//                MessageBox.Show($"Ошибка при загрузке данных: {ex.Message}", "Ошибка",
//                    MessageBoxButton.OK, MessageBoxImage.Error);
//            }
//        }

//        private void Save_Click(object sender, RoutedEventArgs e)
//        {
//            try
//            {
//                // Проверка заполнения обязательных полей
//                if (cbAnimalType.SelectedItem == null || string.IsNullOrWhiteSpace(tbAnimalName.Text) ||
//                    cbAnimalGender.SelectedItem == null || cbDoctor.SelectedItem == null ||
//                    !dpDate.SelectedDate.HasValue)
//                {
//                    MessageBox.Show("Пожалуйста, заполните все обязательные поля", "Предупреждение",
//                        MessageBoxButton.OK, MessageBoxImage.Warning);
//                    return;
//                }

//                // Создание нового животного
//                var newAnimal = new Animal
//                {
//                    Name = tbAnimalName.Text,
//                    IdTypeAni = ((TypeAni)cbAnimalType.SelectedItem).ID,
//                    IdGender = ((Gender)cbAnimalGender.SelectedItem).ID,
//                    Weight_kg = double.TryParse(tbWeight.Text, out var weight) ? weight : 0,
//                    Height_cm = double.TryParse(tbHeight.Text, out var height) ? height : 0
//                };

//                // Создание новой записи приема
//                var newAppointment = new Appointment
//                {
//                    IDAnimal = newAnimal.ID,
//                    IDDoc = (int)cbDoctor.SelectedItem.GetType().GetProperty("ID").GetValue(cbDoctor.SelectedItem),
//                    DateAccep = dpDate.SelectedDate.Value,
//                    Comment = tbComment.Text,
//                    IsDelete = false
//                };

//                // Сохранение в БД
//                Connection.vetclinicEntities.Animal.Add(newAnimal);
//                Connection.vetclinicEntities.Appointment.Add(newAppointment);
//                Connection.vetclinicEntities.SaveChanges();

//                MessageBox.Show("Прием успешно добавлен", "Успех",
//                    MessageBoxButton.OK, MessageBoxImage.Information);

//                DataSaved?.Invoke(); // Оповещаем об успешном сохранении
//                this.Close();
//            }
//            catch (Exception ex)
//            {
//                MessageBox.Show($"Ошибка при сохранении приема: {ex.Message}", "Ошибка",
//                    MessageBoxButton.OK, MessageBoxImage.Error);
//            }
//        }

//        private void Cancel_Click(object sender, RoutedEventArgs e)
//        {
//            this.Close();
//        }
//    }
//}
using System;
using System.Linq;
using System.Windows;
using VetClinic.db;

namespace VetClinic.window
{
    public partial class WindowAdd : Window
    {
        public event Action DataSaved;

        public WindowAdd()
        {
            InitializeComponent();
            LoadData();
        }

        private void LoadData()
        {
            try
            {
                // Загрузка типов животных
                cbAnimalType.ItemsSource = Connection.vetclinicEntities.TypeAni.ToList();
                cbAnimalType.DisplayMemberPath = "Name";
                cbAnimalType.SelectedValuePath = "ID";

                // Загрузка полов животных
                cbAnimalGender.ItemsSource = Connection.vetclinicEntities.Gender.ToList();
                cbAnimalGender.DisplayMemberPath = "Name";
                cbAnimalGender.SelectedValuePath = "ID";

                // Загрузка врачей (просто список врачей без сложных преобразований)
                cbDoctor.ItemsSource = Connection.vetclinicEntities.Doctor.ToList();
                cbDoctor.DisplayMemberPath = "LastName"; // Можно изменить на нужное отображение
                cbDoctor.SelectedValuePath = "ID";

                dpDate.SelectedDate = DateTime.Today;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при загрузке данных: {ex.Message}", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Проверка заполнения обязательных полей
                if (cbAnimalType.SelectedItem == null || string.IsNullOrWhiteSpace(tbAnimalName.Text) ||
                    cbAnimalGender.SelectedItem == null || cbDoctor.SelectedItem == null ||
                    !dpDate.SelectedDate.HasValue)
                {
                    MessageBox.Show("Пожалуйста, заполните все обязательные поля", "Предупреждение",
                        MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                // Создание нового животного
                var newAnimal = new Animal
                {
                    Name = tbAnimalName.Text,
                    IdTypeAni = (int)cbAnimalType.SelectedValue,
                    IdGender = (int)cbAnimalGender.SelectedValue,
                    Weight_kg = double.TryParse(tbWeight.Text, out var weight) ? weight : 0,
                    Height_cm = double.TryParse(tbHeight.Text, out var height) ? height : 0
                };

                // Создание новой записи приема
                var newAppointment = new Appointment
                {
                    Animal = newAnimal, // Связываем животное с приемом
                    IDDoc = (int)cbDoctor.SelectedValue,
                    DateAccep = dpDate.SelectedDate.Value,
                    Comment = tbComment.Text,
                    IsDelete = false
                };

                // Сохранение в БД
                Connection.vetclinicEntities.Appointment.Add(newAppointment);
                Connection.vetclinicEntities.SaveChanges();

                MessageBox.Show("Прием успешно добавлен", "Успех",
                    MessageBoxButton.OK, MessageBoxImage.Information);

                DataSaved?.Invoke();
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при сохранении приема: {ex.Message}", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}