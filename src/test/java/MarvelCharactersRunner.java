import com.intuit.karate.junit5.Karate;


class MarvelCharactersRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run(
                "features/get_all_characters",
                "features/get_character_by_id",
                "features/create_character",
                "features/update_character",
                "features/delete_character"
        ).relativeTo(getClass());
    }
}
