#include <gtk/gtk.h>
#include <pthread.h>

// Estructura para pasar datos al hilo
typedef struct {
    GtkWidget *label;
} ThreadData;

// Función de actualización del label en el hilo
void *updateLabel(void *data) {
    ThreadData *threadData = (ThreadData *)data;

    for (int i = 1; i <= 100; i++) {
        char buffer[10];
        snprintf(buffer, sizeof(buffer), "%d", i);

        // Actualiza el texto del label en el hilo
        gtk_label_set_text(GTK_LABEL(threadData->label), buffer);

        // Espera un tiempo para simular un proceso
        usleep(100000); // 100ms
    }

    return NULL;
}

int main(int argc, char *argv[]) {
    // Inicializa GTK
    gtk_init(&argc, &argv);

    // Crea la ventana principal
    GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(window), "Contador con GTK");
    gtk_window_set_default_size(GTK_WINDOW(window), 200, 100);

    // Crea el label inicializado a "0"
    GtkWidget *label = gtk_label_new("0");

    // Agrega el label a la ventana
    gtk_container_add(GTK_CONTAINER(window), label);

    // Muestra todos los widgets
    gtk_widget_show_all(window);

    // Inicializa la estructura de datos para el hilo
    ThreadData threadData;
    threadData.label = GTK_LABEL(label);

    // Crea el hilo
    pthread_t thread;
    pthread_create(&thread, NULL, updateLabel, &threadData);

    // Maneja el evento de cierre de la ventana
    g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);

    // Ejecuta el bucle principal de GTK
    gtk_main();

    // Espera a que el hilo termine antes de salir
    pthread_join(thread, NULL);

    return 0;
}
