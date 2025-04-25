using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using VetClinic.db;
using VetClinic.window;

namespace VetClinic.pages
{
    public partial class PageAutorization : Page
    {
        public PageAutorization()
        {
            InitializeComponent();
        }

        private void Login_Click(object sender, RoutedEventArgs e)
        {
            string login = txtUsername.Text.Trim();
            string password = txtPassword.Password.Trim();

            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Введите логин и пароль");
                return;
            }

            try
            {
                var user = Connection.vetclinicEntities.Users
                    .FirstOrDefault(u => u.Login == login && u.Password == password);

                if (user != null)
                {
                    if (user.IsActive == true)
                    {
                    
                        user.LastLoginDate = DateTime.Now;
                        Connection.vetclinicEntities.SaveChanges();

                     
                        WindowAppointment wind = new WindowAppointment();
                        wind.Show();

                  
                        if (Window.GetWindow(this) is Window mainWindow)
                        {
                            mainWindow.Close();
                        }
                    }
                    else
                    {
                        MessageBox.Show("Ваш аккаунт деактивирован. Обратитесь к администратору.");
                    }
                }
                else
                {
                    MessageBox.Show("Неверный логин или пароль");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при авторизации: {ex.Message}");
            }
        }
    }
}