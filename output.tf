output "access-frontend-at" {
    value = join(":",tolist([google_compute_instance.frontend.network_interface[0].access_config[0].nat_ip,"8080"]))
    description = "The instance name for the fronend instance"
}
output "frontend" {
    value = google_compute_instance.frontend.network_interface[0].network_ip
    description = "The instance IP for the frontend"
}
output "checkout" {
    value = google_compute_instance.checkout.network_interface[0].network_ip
    description = "The instance IP for the checkout"
}
output "ad" {
    value = google_compute_instance.ad.network_interface[0].network_ip
    description = "The instance IP for the ad"
}
output "recommendation" {
    value = google_compute_instance.recommendation.network_interface[0].network_ip
    description = "The instance IP for the recommendation"
}
output "payment" {
    value = google_compute_instance.payment.network_interface[0].network_ip
    description = "The instance IP for the payment"
}
output "email" {
    value = google_compute_instance.email.network_interface[0].network_ip
    description = "The instance IP for the email"
}
output "productcatalog" {
    value = google_compute_instance.productcatalog.network_interface[0].network_ip
    description = "The instance IP for the productcatalog"
}
output "shipping" {
    value = google_compute_instance.shipping.network_interface[0].network_ip
    description = "The instance IP for the shipping"
}
output "currency" {
    value = google_compute_instance.currency.network_interface[0].network_ip
    description = "The instance IP for the currency"
}
output "cart" {
    value = google_compute_instance.cart.network_interface[0].network_ip
    description = "The instance IP for the cart"
}
output "redis" {
    value = google_compute_instance.redis.network_interface[0].network_ip
    description = "The instance IP for the redis"
}