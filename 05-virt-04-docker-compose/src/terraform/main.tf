terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQAAAABHHr5xAATuwZ6laIKQfUlPsy3aJWeIZbU"
  cloud_id  = "b1gqbheu8mgbdf2tnugi"
  folder_id = "b1gui6lu939tdppd1ltj"
  zone      = "ru-central1-a"
}
