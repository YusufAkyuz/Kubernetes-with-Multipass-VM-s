# Kubernetes kümesinin sıfırdan kurulumu ve güncellenmesi için gerekli komut akışını içeren notlar.
#Önce her şeyi en başa saralım. terraform klasörüne git ve makineleri tamamen sil:
cd ~/K8s_Cluster_Local_Environment/terraform
terraform destroy -auto-approve

----------------------------------------------------

#Makineleri sırayla ve temiz bir şekilde tekrar oluştur:
terraform apply -parallelism=1 -auto-approve
#Bu aşamada Multipass yeni IP adresleri atayabilir. 
terraform output 
#komutuyla üzerinden IP'leri tekrar kontrol et.

----------------------------------------------------

#Eğer IP adresleri değiştiyse, ansible/inventory.ini dosyasındaki IP'leri yeni halleriyle güncelle. Ardından bağlantıyı test et:

cd ../ansible
ansible all -m pin

----------------------------------------------------

ansible-playbook k8s-setup.yml