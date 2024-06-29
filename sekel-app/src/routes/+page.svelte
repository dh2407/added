<script>
    import { Radio, Button } from "flowbite-svelte";
    import { ArrowRightOutline } from "flowbite-svelte-icons";

    let selectedOption = "";
    const options = [
        { value: "update", label: "UPDTAE" },
        { value: "change", label: "CHANGE" },
        { value: "edit", label: "EDIT" },
        { value: "modify", label: "MODIFY" },
    ];
</script>

<div class="bg-white flex flex-col items-stretch w-full">
    <div class="h-11 bg-zinc-300"></div>
    <div class="px-4 ">
       
            <div class="py-6 ">
                Which SQL command is used to modify existing records in a table
                ?
            </div>
      
        <div
            class="flex flex-col gap-1 mb-4 "
        >
            {#each options as option}
                <Radio
                    class="text-sm p-2 bg-zinc-100  min-h-12  "
                    bind:group={selectedOption}
                    value={option.value}
                    name={option.value}
                >
                   {option.label}</Radio
                >
            {/each}
        </div>

        <div class="flex flex-row justify-end  ">
            <Button class="rounded border border-orange-200 ">
                Next <ArrowRightOutline class="w-5 h-5 ms-2" />
            </Button>
        </div>
    </div>
</div>
