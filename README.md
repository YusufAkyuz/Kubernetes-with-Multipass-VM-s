# Kubernetes with Multipass VM's

Bu proje, Multipass kullanarak yerel makinenizde çok düğümlü (1 Master, 3 Worker) bir Kubernetes kümesini Terraform ve Ansible ile otomatize edilmiş bir şekilde kurmanıza olanak tanır.

## 🚀 Proje İçeriği

- **Terraform:** Sanal makinelerin (Multipass) oluşturulması ve başlangıç yapılandırması (cloud-init).
- **Ansible:** İşletim sistemi hazırlığı, Containerd kurulumu, Kubeadm konfigürasyonu ve Ağ eklentisi (Flannel) kurulumu.
- **Multipass:** Hafif sanal makine yönetimi.

## 📋 Ön Gereksinimler

Başlamadan önce sisteminizde aşağıdaki araçların kurulu olduğundan emin olun:

- [Multipass](https://multipass.run/install)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## 📁 Proje Yapısı

```text
.
├── ansible/
│   ├── ansible.cfg          # Ansible konfigürasyonu
│   ├── inventory.ini        # Sunucu IP adresleri ve grupları
│   └── k8s-setup.yml        # K8s kurulum playbook'u
├── ssh_keys/                # VM erişimi için SSH anahtarları
├── terraform/
│   ├── main.tf              # Altyapı tanımı (Master + 3 Worker)
│   └── cloud-init.yaml      # VM başlangıç script'i
├── Access_VM_from_local     # Yerel erişim rehberi
└── cluster_installation     # Kurulum komutları notları
```

## 🛠️ Kurulum Adımları

### 1. Altyapıyı Oluşturma (Terraform)
Önce Terraform ile sanal makineleri oluşturun:

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

Kurulum bittiğinde master ve worker IP adreslerini çıktı olarak göreceksiniz.

### 2. Ansible Envanterini Güncelleme
`ansible/inventory.ini` dosyasını açın ve Terraform çıktısındaki yeni IP adreslerini ilgili bölümlere (`[master]` ve `[workers]`) ekleyin.

### 3. Kubernetes Kurulumu (Ansible)
Tüm süreci otomatize etmek için playbook'u çalıştırın:

```bash
cd ../ansible
ansible-playbook k8s-setup.yml
```

## 🔍 Erişim ve Kontrol

Kurulum tamamlandıktan sonra Master node'a bağlanıp küme durumunu kontrol edebilirsiniz:

```bash
multipass shell k8s-master
kubectl get nodes
```

## ⚠️ Önemli Notlar

- **Swap:** Kubernetes gereksinimi olarak swap otomatik olarak kapatılır.
- **CNI:** Projede ağ eklentisi olarak **Flannel** kullanılmaktadır (Pod Network CIDR: `10.244.0.0/16`).
- **Kaynaklar:** Her makine varsayılan olarak 2 CPU ve 2GB RAM (Master için 4GB) ile yapılandırılmıştır. `main.tf` üzerinden bunları değiştirebilirsiniz.

## 📄 Lisans
Bu proje eğitim amaçlıdır.
